//
//  ViewController.swift
//  Conecta4
//
//  Created by Csweb on 27/09/22.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var turnImage: UIImageView!
	@IBOutlet weak var resetBtn: UIButton!
	@IBOutlet weak var redScoreLabel: UILabel!
	@IBOutlet weak var yellowScoreLabel: UILabel!

	var redScore = 0
	var yellowScore = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		resetBtn.isHidden = true
		resetBoard()
		setCellWidthHeight()
	}

	func setCellWidthHeight() {
		let width = collectionView.frame.size.width / 9
		let height = collectionView.frame.size.height / 6
		let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		flowLayout.itemSize = CGSize(width: width, height: height)
	}

	@IBAction func resetBtnAction(_ sender: Any) {
		resetBtn.isHidden = true
		resetBoard()
		resetCells()
	}
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {

	func numberOfSections(in cv: UICollectionView) -> Int {
		board.count
	}

	func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		board[section].count
	}

	func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = cv.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! BoardCell
		let boardItem = getBoardItem(indexPath)
		cell.image.tintColor = boardItem.tileColor()
		return cell
	}

	func collectionView(_ cv: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let column = indexPath.item
		if var boardItem = getLowestEmptyBoardItem(column) {
			if let cell = collectionView.cellForItem(at: boardItem.indexPath) as? BoardCell {
				cell.image.tintColor = currentTurnColor()
				boardItem.tile = currentTurnTile()
				updateBoardWithBoardItem(boardItem)

				if victoryAchieved() {
					if yellowTurn() {
						yellowScore += 1
						yellowScoreLabel.text = String(yellowScore)
					}

					if redTurn() {
						redScore += 1
						redScoreLabel.text = String(redScore)
					}

					resultAlert(currentTurnVictoryMessage())
				}

				if boardIsFull() {
					resultAlert("Empate")
				}

				toggleTurn(turnImage)
			}
		}
	}

	func resultAlert(_ title: String) {
		let message = "\nRojo: \(redScore)\n\nAmarillo: \(yellowScore)"
		let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		ac.addAction(UIAlertAction(title: "Aceptar", style: .default) { [self] _ in
			resetBtn.isHidden = false
		})
		present(ac, animated: true)
	}

	func resetCells() {
		for cell in collectionView.visibleCells as! [BoardCell] {
			cell.image.tintColor = .white
		}
	}
}

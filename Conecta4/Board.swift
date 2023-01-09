//
//  Board.swift
//  Conecta4
//
//  Created by Csweb on 27/09/22.
//

import Foundation
import UIKit

var board = [[BoardItem]]()

func resetBoard() {
	board.removeAll()

	for row in 0...5 {
		var rowArray = [BoardItem]()

		for column in 0...6 {
			let indexPath = IndexPath(item: column, section: row)
			let boardItem = BoardItem(indexPath: indexPath, tile: Tile.empty)
			rowArray.append(boardItem)
		}

		board.append(rowArray)
	}
}

func getBoardItem(_ indexPath: IndexPath) -> BoardItem {
	board[indexPath.section][indexPath.item]
}

func getLowestEmptyBoardItem(_ column: Int) -> BoardItem? {
	for row in (0...5).reversed() {
		let boardItem = board[row][column]
		if boardItem.emptyTile() {
			return boardItem
		}
	}

	return nil
}

func updateBoardWithBoardItem(_ boardItem: BoardItem) {
	if let indexPath = boardItem.indexPath {
		board[indexPath.section][indexPath.item] = boardItem
	}
}

func boardIsFull() -> Bool {
	for row in board {
		for col in row {
			if col.emptyTile() {
				return false
			}
		}
	}
	return true
}

func victoryAchieved() -> Bool {
	horizontalVictory() || verticalVictory() || diagonalVictory()
}

func horizontalVictory() -> Bool {
	for row in board {
		var consecutive = 0
		for col in row {
			if col.tile == currentTurnTile() {
				consecutive += 1
				if consecutive >= 4 {
					return true
				}
			} else {
				consecutive = 0
			}
		}
	}
	return false
}

func verticalVictory() -> Bool {
	for col in 0...board.count {
		if checkVerticalColumn(col) {
			return true
		}
	}
	return false
}

func checkVerticalColumn(_ columnToCheck: Int) -> Bool {
	var consecutive = 0
	for row in board {
		if row[columnToCheck].tile == currentTurnTile() {
			consecutive += 1
			if consecutive >= 4 {
				return true
			}
		} else {
			consecutive = 0
		}
	}
	return false
}

func diagonalVictory() -> Bool {
	for col in 0...board.count {
		if checkDiagonalColumn(col, true, true) {
			return true
		}
		if checkDiagonalColumn(col, true, false) {
			return true
		}
		if checkDiagonalColumn(col, false, true) {
			return true
		}
		if checkDiagonalColumn(col, false, false) {
			return true
		}
	}
	return false
}

func checkDiagonalColumn(_ columnToCheck: Int, _ moveUp: Bool, _ reverseRows: Bool) -> Bool {
	var movingColumn = columnToCheck
	var consecutive = 0
	if reverseRows {
		for row in board.reversed() {
			if movingColumn < row.count && movingColumn >= 0 {
				if row[movingColumn].tile == currentTurnTile() {
					consecutive += 1
					if consecutive >= 4 {
						return true
					}
				} else {
					consecutive = 0
				}
				movingColumn = moveUp ? movingColumn + 1 : movingColumn - 1
			}
		}
	} else {
		for row in board {
			if movingColumn < row.count && movingColumn >= 0 {
				if row[movingColumn].tile == currentTurnTile() {
					consecutive += 1
					if consecutive >= 4 {
						return true
					}
				} else {
					consecutive = 0
				}
				movingColumn = moveUp ? movingColumn + 1 : movingColumn - 1
			}
		}
	}
	return false
}

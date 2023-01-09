//
//  Turn.swift
//  Conecta4
//
//  Created by Csweb on 27/09/22.
//

import Foundation
import UIKit

enum Turn {
	case red, yellow
}

var currentTurn = Turn.yellow

func toggleTurn(_ turnImage: UIImageView) {
	if yellowTurn() {
		currentTurn = Turn.red
		turnImage.tintColor = .red
	} else {
		currentTurn = Turn.yellow
		turnImage.tintColor = .systemYellow
	}
}

func yellowTurn() -> Bool {
	currentTurn == .yellow
}

func redTurn() -> Bool {
	currentTurn == .red
}

func currentTurnTile() -> Tile {
	yellowTurn() ? .yellow : .red
}

func currentTurnColor() -> UIColor {
	yellowTurn() ? .systemYellow : .red
}

func currentTurnVictoryMessage() -> String {
	yellowTurn() ? "El de amarillo gana" : "El de rojo gana"
}

//
//  BoardItem.swift
//  Conecta4
//
//  Created by Csweb on 27/09/22.
//

import Foundation
import UIKit

enum Tile {
	case red, yellow, empty, green
}

struct BoardItem {
	var indexPath: IndexPath!
	var tile: Tile!

	func yellowTile() -> Bool {
		tile == Tile.yellow
	}

	func redTile() -> Bool {
		tile == Tile.red
	}

	func emptyTile() -> Bool {
		tile == Tile.empty
	}

	func tileColor() -> UIColor {
		if redTile() {
			return .red
		}

		if yellowTile() {
			return .systemYellow
		}

		return .white
	}
}

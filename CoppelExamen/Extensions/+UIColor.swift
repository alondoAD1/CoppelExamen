//
//  +UIColor.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import UIKit

extension UIColor {
    enum AssetIdentifier: String {
        case background = "background"
        case backgrounSecundary = "backgrounSecundary"
        case textPrimary = "textPrimary"
        case textSecundary = "textSecundary"
        case segmentButton = "segmentButtons"
        case buttonActive = "buttonActive"
        case buttonInactive = "buttonInactive"
        case cardView = "cardView"
        case error = "error"
        case placeHolder = "placeHolder"
    }

    convenience init?(colorIdentifier identifier: AssetIdentifier) {
        self.init(named: identifier.rawValue)
    }
    
}

//
//  ButtonCustom.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import UIKit

class UIButtonCustom: UIButton {
    
    private var action: (() -> ())?
    
    func addTapGesture(action: @escaping () -> ()) {
        self.action = action
        addTarget(self, action: #selector(executeAction), for: .touchUpInside)
    }
    
    @objc private func executeAction() {
        action?()
    }
    
}

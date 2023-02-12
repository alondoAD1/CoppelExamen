//
//  +UserDefaults.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import Foundation

extension UserDefaults {
    
    static func setValues(value: Any?, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    
    static func delete(forKey: String) {
        UserDefaults.standard.removeObject(forKey: forKey)
    }

    static func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

}

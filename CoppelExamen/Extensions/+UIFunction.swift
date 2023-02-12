//
//  +UIFunction.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import Foundation

func create<T: NSObject>(_ setup: (T) -> ()) -> T {
    let obj = T()
    setup(obj)
    return obj
}

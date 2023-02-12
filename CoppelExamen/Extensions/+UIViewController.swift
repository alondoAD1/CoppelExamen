//
//  +UIViewController.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 12/02/23.
//

import UIKit

extension UIViewController {
    func loader(message: String) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let loadingIndicador = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicador.hidesWhenStopped = true
        loadingIndicador.style = UIActivityIndicatorView.Style.large
        loadingIndicador.startAnimating()
        alert.view.addSubview(loadingIndicador)
        return alert
    }
    
    func pausarLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
    
    func erroAlert(message: String) {
        let alert = UIAlertController(title: "Atencion", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
}

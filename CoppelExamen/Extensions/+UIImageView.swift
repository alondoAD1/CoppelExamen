//
//  +UIImageView.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 11/02/23.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadimagenUsandoCacheConURLString(urlString: String) {
        self.image = nil
    
        //checar cache
        if let cacheImagen = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cacheImagen
            return
        }
    
        let url = URL(string: urlString)
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if let data = data {
                    
                    if error != nil {
                        print(error as Any)
                        return
                    }
                    
                    DispatchQueue.main.async { // Correct
                        if let imageDescargada = UIImage(data: data){
                            imageCache.setObject(imageDescargada, forKey: urlString as AnyObject)
                            self.image = imageDescargada
                        }
                    }
                }
            }
        task.resume()
    }
}

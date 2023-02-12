//
//  +UIImage.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import UIKit

extension UIImage {
    
    enum Icon {
        case logo
        case thumbBackground
        case star
        case starFill
        case imageEmpty
        case listDash
        case favorite
        case profile
        case play
        
        var image: UIImage {
            switch self {
            case .logo: return UIImage(named: "logoTMDB") ?? UIImage()
            case .thumbBackground: return UIImage(named: "thumbBackground") ?? UIImage()
            case .starFill: return UIImage(systemName: "star.fill") ?? UIImage()
            case .star: return UIImage(systemName: "star") ?? UIImage()
            case .imageEmpty: return UIImage(named: "imgBroken") ?? UIImage()
            case .listDash: return UIImage(systemName: "list.dash") ?? UIImage()
            case .favorite: return UIImage(systemName: "heart.fill") ?? UIImage()
            case .profile: return UIImage(systemName: "person.text.rectangle.fill") ?? UIImage()
            case .play: return UIImage(systemName: "play.circle.fill") ?? UIImage()
            }
        }

    }
    
}





//
//  UILogin.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import UIKit

protocol delegateUILogin: AnyObject {
    func actionLogin()
}

class UILogin: UIView {
    
    weak var delegate: delegateUILogin?
    var screenSize = UIScreen.main.bounds.size
    
    lazy var imgBackground: UIImageView = create {
        $0.image = UIImage.Icon.thumbBackground.image
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var effectView: UIView = create {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(colorIdentifier: .textPrimary)?.withAlphaComponent(0.5).cgColor ?? UIColor.black.cgColor,
                                UIColor(colorIdentifier: .background)?.withAlphaComponent(1).cgColor ?? UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x : 0.0, y : 0)
        gradientLayer.endPoint = CGPoint(x :0.0, y: 0.85)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 250)
        $0.layer.insertSublayer(gradientLayer, at: 0)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var stackView: UIStackView = create {
        $0.alignment = .center
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 25
        $0.isUserInteractionEnabled = true
        $0.addArrangedSubview(imgLogo)
        $0.addArrangedSubview(textFieldUsername)
        $0.addArrangedSubview(textFieldPassword)
        $0.addArrangedSubview(btnLogIn)
        $0.addArrangedSubview(lblError)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var imgLogo: UIImageView = create {
        $0.image = UIImage.Icon.logo.image
    }
    
    lazy var textFieldUsername: UITextField = create {
        $0.attributedPlaceholder = NSAttributedString(string: UIConstants.UILogin_username, attributes: [NSAttributedString.Key.foregroundColor : UIColor(colorIdentifier: .placeHolder) ?? UIColor.systemGray])
        $0.textColor = UIColor(colorIdentifier: .textPrimary)
        $0.backgroundColor = UIColor(colorIdentifier: .cardView)
        $0.borderStyle = .roundedRect
    }
    
    lazy var textFieldPassword: UITextField = create {
        $0.attributedPlaceholder = NSAttributedString(string: UIConstants.UILogin_password, attributes: [NSAttributedString.Key.foregroundColor : UIColor(colorIdentifier: .placeHolder) ?? UIColor.systemGray])
        $0.textColor = UIColor(colorIdentifier: .textPrimary)
        $0.backgroundColor = UIColor(colorIdentifier: .cardView)
        $0.borderStyle = .roundedRect
    }
    
    lazy var btnLogIn: UIButtonCustom = create {
        $0.setTitle(UIConstants.UILogin_logIn, for: .normal)
        $0.setTitleColor(UIColor(colorIdentifier: .cardView), for: .normal)
        $0.backgroundColor = UIColor(colorIdentifier: .buttonInactive)
        $0.addTapGesture {
            self.delegate?.actionLogin()
        }
    }
    
    lazy var lblError: UILabel = create {
        $0.textColor = UIColor(colorIdentifier: .error)
        $0.font = .systemFont(ofSize: 10)
    }
    
    func setLayoutConstraint(view: UIView) {
        view.addSubview(imgBackground)
        view.addSubview(effectView)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            imgBackground.topAnchor.constraint(equalTo: view.topAnchor),
            imgBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            imgBackground.rightAnchor.constraint(equalTo: view.rightAnchor),
            imgBackground.heightAnchor.constraint(equalToConstant: 250),
            
            effectView.topAnchor.constraint(equalTo: imgBackground.topAnchor),
            effectView.leftAnchor.constraint(equalTo: imgBackground.leftAnchor),
            effectView.rightAnchor.constraint(equalTo: imgBackground.rightAnchor),
            effectView.bottomAnchor.constraint(equalTo: imgBackground.bottomAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            imgLogo.heightAnchor.constraint(equalToConstant: 80),
            imgLogo.widthAnchor.constraint(equalToConstant: 100),
            
            textFieldUsername.heightAnchor.constraint(equalToConstant: 50),
            textFieldUsername.widthAnchor.constraint(equalToConstant: screenSize.width - 80),
            
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),
            textFieldPassword.widthAnchor.constraint(equalToConstant: screenSize.width - 80),

            btnLogIn.heightAnchor.constraint(equalToConstant: 50),
            btnLogIn.widthAnchor.constraint(equalToConstant: screenSize.width - 80)
        ])
    }
    
}

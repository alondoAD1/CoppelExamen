//
//  UIProfile.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 11/02/23.
//

import UIKit

class UIProfile {
    
    private var screenSize = UIScreen.main.bounds.size

    lazy var lblProfile: UILabel = create {
        $0.text = UIConstants.Profile.Title
        $0.textColor = UIColor(colorIdentifier: .textPrimary)
        $0.font = .boldSystemFont(ofSize: 20)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var imgProfile: UIImageView = create {
        $0.layer.cornerRadius = 50
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleToFill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var lblUserName: UILabel = create {
        $0.textColor = UIColor(colorIdentifier: .textPrimary)
        $0.font = .boldSystemFont(ofSize: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var lblSectionCollectionView: UILabel = create {
        $0.text = UIConstants.Profile.Section_collectionView
        $0.textColor = UIColor(colorIdentifier: .textPrimary)
        $0.font = .boldSystemFont(ofSize: 17)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var collectionView: UICollectionView = {
        let item = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 0)
        layout.itemSize = CGSize(width: (screenSize.width/2) - 30, height: 300)
        item.setCollectionViewLayout(layout, animated: true)
        item.register(DashboardCollectionViewCell.self, forCellWithReuseIdentifier: DashboardCollectionViewCell.indentifier)
        item.backgroundColor = .clear
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    func setConstraintLayout(view: UIView) {
        view.addSubview(lblProfile)
        view.addSubview(imgProfile)
        view.addSubview(lblUserName)
        view.addSubview(lblSectionCollectionView)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            lblProfile.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            lblProfile.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            
            imgProfile.topAnchor.constraint(equalTo: lblProfile.bottomAnchor, constant: 50),
            imgProfile.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            imgProfile.heightAnchor.constraint(equalToConstant: 100),
            imgProfile.widthAnchor.constraint(equalToConstant: 100),
            
            lblUserName.centerYAnchor.constraint(equalTo: imgProfile.centerYAnchor),
            lblUserName.leftAnchor.constraint(equalTo: imgProfile.rightAnchor, constant: 15),
            
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 340),
            
            lblSectionCollectionView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10),
            lblSectionCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
            
        ])
    }
    
    func setImageUrl(imagenURL: String?) {
        guard let url = imagenURL else {
            imgProfile.image = UIImage.Icon.imageEmpty.image
            return
        }
        imgProfile.loadimagenUsandoCacheConURLString(urlString: url)
    }
}

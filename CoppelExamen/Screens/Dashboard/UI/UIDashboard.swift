//
//  UIDashboard.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import UIKit

protocol delegateUIDashboard: AnyObject {
    func selectBtn(index: Int)
    func selectBtnMenuNavBar()
}

class UIDashboard {
    
    weak var delegate: delegateUIDashboard?
    var screenSize = UIScreen.main.bounds.size
    
    lazy var seggmentButtons: UISegmentedControl = create {
        for (index, value) in UIConstants.UIDashboard_Segment_title.enumerated() {
            $0.insertSegment(withTitle: value, at: index, animated: true)
            $0.tag = index
        }
        $0.selectedSegmentIndex = 0
        $0.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var collectionView: UICollectionView = {
        let item = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = .zero
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        layout.itemSize = CGSize(width: (screenSize.width/2) - 30, height: 300)
        item.setCollectionViewLayout(layout, animated: true)
        item.register(DashboardCollectionViewCell.self, forCellWithReuseIdentifier: DashboardCollectionViewCell.indentifier)
        item.backgroundColor = .clear
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    func setLayoutConstraint(view: UIView) {
        view.addSubview(seggmentButtons)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            seggmentButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            seggmentButtons.widthAnchor.constraint(equalToConstant: screenSize.width - 50),
            seggmentButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            seggmentButtons.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: seggmentButtons.bottomAnchor, constant: 20),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setNavigationItem(item: UINavigationItem) {
        let btnMenu = UIButtonCustom(type: .custom)
        btnMenu.setImage(UIImage.Icon.listDash.image.withRenderingMode( .alwaysTemplate), for: .normal)
        btnMenu.tintColor = UIColor(colorIdentifier: .textSecundary) ?? .black
        btnMenu.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        item.rightBarButtonItems = [UIBarButtonItem(customView: btnMenu)]
        btnMenu.addTapGesture {
            self.delegate?.selectBtnMenuNavBar()
        }
    }
    
}

//MARK: IBActions
extension UIDashboard {
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
        delegate?.selectBtn(index: segmentedControl.selectedSegmentIndex)
    }
}

//
//  DashboardCollectionViewCell.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import UIKit

protocol DashboardCVCellProtocol: AnyObject {
    func didTapFavorite(data: FavoriteModel)
}

internal class DashboardCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = String(describing: DashboardCollectionViewCell.self)
    weak var delegate: DashboardCVCellProtocol?
    private var modelData = FavoriteModel()
    
    lazy var imgContent: UIImageView = create {
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
        $0.contentMode = .scaleToFill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var lblTitle: UILabel = create {
        $0.textColor = UIColor(colorIdentifier: .textPrimary)
        $0.font = .boldSystemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var lblDate: UILabel = create {
        $0.textColor = UIColor(colorIdentifier: .textPrimary)
        $0.font = .systemFont(ofSize: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var imgRate: UIImageView = create {
        $0.image = UIImage.Icon.starFill.image.withTintColor(UIColor(colorIdentifier: .textPrimary) ?? .darkGray)
        $0.tintColor = UIColor(colorIdentifier: .textPrimary)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var lblRate: UILabel = create {
        $0.textColor = UIColor(colorIdentifier: .textPrimary)
        $0.font = .systemFont(ofSize: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var lblDescription: UILabel = create {
        $0.textColor = UIColor(colorIdentifier: .textSecundary)
        $0.font = .systemFont(ofSize: 10)
        $0.numberOfLines = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var btnFavorite: UIButtonCustom = create {
        $0.setImage(UIImage.Icon.favorite.image.withRenderingMode( .alwaysTemplate), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor(colorIdentifier: .backgrounSecundary)
        contentView.addSubview(imgContent)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblDate)
        contentView.addSubview(imgRate)
        contentView.addSubview(lblRate)
        contentView.addSubview(lblDescription)
        contentView.addSubview(btnFavorite)
        
        NSLayoutConstraint.activate([
            imgContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgContent.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
            imgContent.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
            imgContent.heightAnchor.constraint(equalToConstant: 180),
            
            lblTitle.topAnchor.constraint(equalTo: imgContent.bottomAnchor, constant: 10),
            lblTitle.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 5),
            
            lblDate.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 5),
            lblDate.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 5),
            
            lblRate.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 5),
            lblRate.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -5),
            
            imgRate.rightAnchor.constraint(equalTo: lblRate.leftAnchor, constant: -3),
            imgRate.centerYAnchor.constraint(equalTo: lblRate.centerYAnchor),
            imgRate.heightAnchor.constraint(equalToConstant: 15),
            imgRate.widthAnchor.constraint(equalToConstant: 15),
            
            lblDescription.topAnchor.constraint(equalTo: lblDate.bottomAnchor, constant: 10),
            lblDescription.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 5),
            lblDescription.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -5),
            
            btnFavorite.topAnchor.constraint(equalTo: imgContent.bottomAnchor, constant: -10),
            btnFavorite.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpFavorite(dataLocal: [FavoriteModel], dataService: ResultCustomModel) {
        if dataLocal.contains(where: { $0.id == dataService.id }) {
            btnFavorite.tintColor = .red
        } else {
            btnFavorite.tintColor = UIColor(colorIdentifier: .textSecundary) ?? .black
        }
    }
    
    func setUpData(_ data: FavoriteModel) {
        modelData = data
        lblTitle.text = data.name
        lblDate.text = data.firstAirDate
        lblRate.text = String(data.voteAverage)
        lblDescription.text = data.overview
        setImageUrl(imagenURL: data.posterPath, imagePelicula: imgContent)
        actionTap()
    }
    
    private func setImageUrl(imagenURL: String?, imagePelicula: UIImageView) {
        guard let url = imagenURL else {
            imagePelicula.image = UIImage.Icon.imageEmpty.image
            return
        }
        let urlString = NetworkConstants.endPoint.LoadImages(id: url).url
        imagePelicula.loadimagenUsandoCacheConURLString(urlString: urlString)
    }
    
    func actionTap() {
        btnFavorite.addTapGesture { [weak self] in
            self?.btnFavorite.tintColor = .red
            self?.delegate?.didTapFavorite(data: self?.modelData ?? FavoriteModel())
        }
    }
    
}

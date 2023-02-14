//
//  ProfileViewController.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 11/02/23.
//

import UIKit

class ProfileViewController: UIViewController {

    let uiProfile: UIProfile = UIProfile()
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = UIColor(colorIdentifier: .background)
        uiProfile.collectionView.delegate = self
        uiProfile.collectionView.dataSource = self
        uiProfile.setImageUrl(imagenURL: NetworkConstants.endPoint.ImageProfile.url)
        uiProfile.setConstraintLayout(view: view)
    }
    
    private func configureView() {
        Task {
            try await viewModel.userAccount()
            try await viewModel.getMyFavorite()
        }
        
        bind()
    }
    
    private func bind() {
        viewModel.refreshFavorite = { [weak self] () in
            DispatchQueue.main.async {
                self?.uiProfile.collectionView.reloadData()
            }
        }
        
        viewModel.refreshDataLogin = { [weak self] () in
            DispatchQueue.main.async {
                self?.uiProfile.lblUserName.text = self?.viewModel.dataLogin[0].name
            }
        }
        
    }
    

    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrayFavorite.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCollectionViewCell.indentifier, for: indexPath) as? DashboardCollectionViewCell {
            let data = viewModel.arrayFavorite[indexPath.row]
            cell.btnFavorite.tintColor = .red
            cell.setUpData(FavoriteModel(posterPath: data.posterPath,
                                         popularity: data.popularity,
                                         id: data.id,
                                         backdropPath: data.backdropPath,
                                         voteAverage: data.voteAverage,
                                         overview: data.overview,
                                         firstAirDate: data.firstAirDate,
                                         originCountry: data.originCountry,
                                         genreIDS: data.genreIDS,
                                         originalLanguage: data.originalLanguage,
                                         voteCount: data.voteCount,
                                         name: data.name,
                                         originalName: data.originalName))
            return cell
        }
        return UICollectionViewCell()
    }
    
}

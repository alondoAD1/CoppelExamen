//
//  DashboardPresenter.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import UIKit

class DashboardPresenter: ViewToPresenterDashboardProtocol {

    var movies = [[DashboardCustomModel]]()
    var rowsToDipslay = [ResultCustomModel]()
    var arrFavorites = [ResultCustomModel]()
    var arrCompareFavorite = [FavoriteModel]()
    
    weak var view: PresenterToViewDashboardProtocol?
    var interactor: PresenterToInteractorDashboardProtocol?
    var router: PresenterToRouterDashboardProtocol?
    
    var dataUserAccount: [ModelLogin]?
    
    func viewDidAppear() async {
        arrCompareFavorite.removeAll()
        do {
            guard let myFavorite = try await interactor?.getMyFavorite() else { return }
            arrCompareFavorite = myFavorite

        } catch {
            view?.hideActivity()
        }
    }
    
    func viewDidLoad() async {
        movies.removeAll()
        view?.showActivity()
        do {
            await interactor?.getTV_Popular()
            await interactor?.getTV_TopRated()
            await interactor?.getTV_OnTv()
            await interactor?.getTV_AringToday()
            

            view?.hideActivity()
            view?.onFetchMoviesSuccess()
        }
    }
    
    func refresh(index: Int) {
        switch index {
        case 0:
            rowsToDipslay = movies[index][0].results!
        case 1:
            rowsToDipslay = movies[index][0].results!
        case 2:
            rowsToDipslay = movies[index][0].results!
        default:
            rowsToDipslay = movies[index][0].results!
        }
        view?.onFetchMoviesSuccess()
    }
    
}

//MARK: Api - Success
extension DashboardPresenter: InteractorToPresenterDashboardProtocol {
    func fetchTVPopularSuccess(data: [DashboardCustomModel]) {
        movies.append(data)
        rowsToDipslay = movies[0][0].results!
    }
    
    func fetchTVTopRatedSuccess(data: [DashboardCustomModel]) {
        movies.append(data)
    }
    
    func fetchTVOnTVSuccess(data: [DashboardCustomModel]) {
        movies.append(data)
    }
    
    func fetchTVAringTodaySuccess(data: [DashboardCustomModel]) {
        movies.append(data)
    }
    
}

//MARK: Api - Error
extension DashboardPresenter {
    func fetchTVPopularFailure(error: String) {
        view?.hideActivity()
        view?.onFetchMoviewsFailure(error: String(describing: error).appending(UIConstants.Dashboard.Errors.error))
    }
    
    func fetchTVTopRatedFailure(error: String) {
        view?.hideActivity()
        view?.onFetchMoviewsFailure(error: String(describing: error).appending(UIConstants.Dashboard.Errors.error))
    }
    
    func fetchTVOnTvFailure(error: String) {
        view?.hideActivity()
        view?.onFetchMoviewsFailure(error: String(describing: error).appending(UIConstants.Dashboard.Errors.error))
    }
    
    func fetchTVAiringTodayFailure(error: String) {
        view?.hideActivity()
        view?.onFetchMoviewsFailure(error: String(describing: error).appending(UIConstants.Dashboard.Errors.error))
    }
}


//MARK: Config CollectionView
extension DashboardPresenter {
    func numberOfRowsInSection() -> Int {
        return rowsToDipslay.count
    }

    func collectionViewCellHeight() -> CGFloat {
        return 280
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        return CGSize(width: screenSize.width/2, height: 260)
    }

    func didSelectRowAt(index: Int) {
        router?.pushToMoviewDetail(on: view,
                                   with: rowsToDipslay[index],
                                   favoriteList: arrCompareFavorite)

    }

    func setCell(collectionView: UICollectionView, forRowAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCollectionViewCell.indentifier, for: indexPath) as? DashboardCollectionViewCell {
            let data = rowsToDipslay[indexPath.row]
            cell.delegate = self
            cell.setUpFavorite(dataLocal: arrCompareFavorite, dataService: data)
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

//MARK: ActionTap
extension DashboardPresenter: DashboardCVCellProtocol {
    
    func tapFavorite(data: FavoriteModel) {
        var reloadContacts: [FavoriteModel] = []
        let decoder = JSONDecoder()
        if let codedReloadContacts = UserDefaults.standard.value(forKey: UserDefaultConstants.favoriteList) as? Data {
            guard let contactsDecoded = try? decoder.decode(Array.self, from: codedReloadContacts) as [FavoriteModel] else {
            return
        }
            reloadContacts = contactsDecoded
        }
        
        reloadContacts.append(data)
    
        let encoder = JSONEncoder()
        guard let encodedReloadContacts = try? encoder.encode(reloadContacts) else {
            return
        }
        
        UserDefaults.standard.set(encodedReloadContacts, forKey: UserDefaultConstants.favoriteList)
        UserDefaults.standard.synchronize()

    }

}

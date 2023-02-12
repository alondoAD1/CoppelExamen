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
//            UserDefaults.standard.removeObject(forKey: UserDefaultConstants.favoriteList)

        } catch {
            view?.hideActivity()
            view?.onFetchMoviewsFailure(error: String(describing: error).appending("- Error al obtener las peliculas"))
        }
    }
    
    func viewDidLoad() async {
        movies.removeAll()
        view?.showActivity()
        do {
            guard let popular = try await interactor?.getTV_Popular() else { return }
            guard let topRated = try await interactor?.getTV_TopRated() else { return }
            guard let onTv = try await interactor?.getTV_OnTv() else { return }
            guard let airToday = try await interactor?.getTV_AringToday() else { return }
            
            movies.append(popular)
            movies.append(topRated)
            movies.append(onTv)
            movies.append(airToday)
            rowsToDipslay = movies[0][0].results!
//            dataUserAccount = userAccount
            view?.hideActivity()
            view?.onFetchMoviesSuccess()
        } catch {
            view?.hideActivity()
            view?.onFetchMoviewsFailure(error: String(describing: error).appending(UIConstants.Dashboard.Errors.error))
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

//MARK: Fetch Info
extension DashboardPresenter: InteractorToPresenterDashboardProtocol {
    func fetchMoviewSuccess(movies: [[DashboardCustomModel]]) {
        view?.hideActivity()
        view?.onFetchMoviesSuccess()
    }
    
    func fetchMoviewFailure(error: String) {
        view?.hideActivity()
        view?.onFetchMoviewsFailure(error: String(describing: error).appending(UIConstants.Dashboard.Errors.error))
    }
    
    func getMovieDetailSuccess(_ detail: DashboardCustomModel) {
//        router?.pushToMoviewDetail(on: view,
//                                   with: detail)
    }
    
    func getMoviewDetailFailure() {
        view?.hideActivity()
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

    }

}

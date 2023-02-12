//
//  DashboardProtocols.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import UIKit

//MARK: View Input (View -> Presenter)
protocol ViewToPresenterDashboardProtocol: AnyObject {
    var view: PresenterToViewDashboardProtocol? { get set }
    var interactor: PresenterToInteractorDashboardProtocol? { get set }
    var router: PresenterToRouterDashboardProtocol? { get set }
    func viewDidAppear() async
    func viewDidLoad() async
    func refresh(index: Int)

    func numberOfRowsInSection() -> Int
    func didSelectRowAt(index: Int)
    func setCell(collectionView: UICollectionView,
                 forRowAt indexPath: IndexPath) -> UICollectionViewCell
    
}

//MARK: View Output (Presenter -> View)
protocol PresenterToViewDashboardProtocol: AnyObject {
    func onFetchMoviesSuccess()
    func onFetchMoviewsFailure(error: String)
    func showActivity()
    func hideActivity()
    
    func getNavigation() -> UINavigationController
}

//MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorDashboardProtocol {
    var presenter: InteractorToPresenterDashboardProtocol? { get set }
    func getTV_Popular() async throws -> [DashboardCustomModel]
    func getTV_TopRated() async throws -> [DashboardCustomModel]
    func getTV_OnTv() async throws -> [DashboardCustomModel]
    func getTV_AringToday() async throws -> [DashboardCustomModel]
    func getAccountData(sessionID: String) async throws -> [ModelLogin]
    func getMyFavorite() async throws -> [FavoriteModel]

    func getMovieDetail(index: Int)
}

//MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterDashboardProtocol: AnyObject {
    func fetchMoviewSuccess(movies: [[DashboardCustomModel]])
    func fetchMoviewFailure(error: String)
    
    func getMovieDetailSuccess(_ detail: DashboardCustomModel)
    func getMoviewDetailFailure()
}

//MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterDashboardProtocol {
    static func createModuleToDashboard() -> UINavigationController?
    static func createModuleOfLogin() -> UIViewController?
    func pushToMoviewDetail(on view: PresenterToViewDashboardProtocol?,
                            with movie: ResultCustomModel,
                            favoriteList: [FavoriteModel])
    func pushToProfile(on view: PresenterToViewDashboardProtocol?,
                            with profileData: ModelLogin)
}

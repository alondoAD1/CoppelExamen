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
    func didTapViewProfile()
    func didLogOut()
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
    func getTV_Popular() async
    func getTV_TopRated() async
    func getTV_OnTv() async
    func getTV_AringToday() async
    func getAccountData(sessionID: String) async throws -> [ModelLogin]
    func getMyFavorite() async throws -> [FavoriteModel]

    func getMovieDetail(index: Int)
}

//MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterDashboardProtocol: AnyObject {
    func fetchTVPopularSuccess(data: [DashboardCustomModel])
    func fetchTVTopRatedSuccess(data: [DashboardCustomModel])
    func fetchTVOnTVSuccess(data: [DashboardCustomModel])
    func fetchTVAringTodaySuccess(data: [DashboardCustomModel])

    func fetchTVPopularFailure(error: String)
    func fetchTVTopRatedFailure(error: String)
    func fetchTVOnTvFailure(error: String)
    func fetchTVAiringTodayFailure(error: String)
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

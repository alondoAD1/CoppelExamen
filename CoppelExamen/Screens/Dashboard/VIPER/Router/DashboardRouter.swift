//
//  DashboardRouter.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import UIKit

class DashboardRouter: PresenterToRouterDashboardProtocol {
    
    static func createModuleToDashboard() -> UINavigationController? {
        let viewController = DashboardViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        let presenter = DashboardPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = DashboardRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DashboardInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        return navigation
    }
    
    static func createModuleOfLogin() -> UIViewController? {
        let viewController = DashboardViewController()
        let presenter = DashboardPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = DashboardRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DashboardInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        return viewController
    }

    func pushToMoviewDetail(on view: PresenterToViewDashboardProtocol?, with movie: ResultCustomModel, favoriteList: [FavoriteModel]) {
        let detailViewController = DetailViewController(data: movie)
        view?.getNavigation().pushViewController(detailViewController, animated: true)
    }
    
    func pushToProfile(on view: PresenterToViewDashboardProtocol?, with profileData: ModelLogin) {

    }
    
    
}

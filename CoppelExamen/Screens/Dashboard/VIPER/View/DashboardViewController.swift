//
//  DashboardViewController.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import UIKit

class DashboardViewController: UIViewController {
    
    var presenter: (ViewToPresenterDashboardProtocol & InteractorToPresenterDashboardProtocol)?
    var uiDashboard: UIDashboard = UIDashboard()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task {
            await presenter?.viewDidAppear()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        Task {
            await presenter?.viewDidLoad()
        }
    }
    
    func setUpUI() {
        title = UIConstants.UIDashboard_NavBar_title
        view.backgroundColor = UIColor(colorIdentifier: .background)
        navigationItem.hidesBackButton = true
        uiDashboard.delegate = self
        uiDashboard.collectionView.delegate = self
        uiDashboard.collectionView.dataSource = self
        uiDashboard.setNavigationItem(item: navigationItem)
        uiDashboard.setLayoutConstraint(view: self.view)
    }
    
}

extension DashboardViewController: PresenterToViewDashboardProtocol {
    func onFetchMoviesSuccess() {
        Task {
            uiDashboard.collectionView.reloadData()
        }
    }
    
    func onFetchMoviewsFailure(error: String) {
        // pantalla de error
    }
    
    func showActivity() {
        // show SplashScreen
    }
    
    func hideActivity() {
        // hide SplashScreen
    }
    
    func getNavigation() -> UINavigationController {
        return self.navigationController ?? UINavigationController()
    }
    
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presenter?.setCell(collectionView: collectionView,
                                  forRowAt: indexPath) ?? UICollectionViewCell()
    }
    
}

//MARK: ActionTap
extension DashboardViewController: delegateUIDashboard {
    func selectBtnMenuNavBar() {
        let alert = UIAlertController(title: String(), message: UIConstants.Dashboard.BottomAlert_Button_title, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: UIConstants.Dashboard.BottomAlert_Button_viewProfile, style: .default , handler:{ (UIAlertAction)in
            let profileViewController = ProfileViewController()
            let navigationController = UINavigationController(rootViewController: profileViewController)
            navigationController.modalPresentationStyle = .pageSheet
            if let sheet = navigationController.sheetPresentationController {
                sheet.detents = [.large()]
            }
            self.present(navigationController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: UIConstants.Dashboard.BottomAlert_Button_myFavorite, style: .default , handler:{ (UIAlertAction) in
//            let profileViewController = DetailViewController()
//            self.navigationController?.pushViewController(profileViewController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: UIConstants.Dashboard.BottomAlert_Button_logOut, style: .default , handler:{ (UIAlertAction) in
            UserDefaults.standard.removeObject(forKey: UserDefaultConstants.favoriteList)
            UserDefaults.standard.removeObject(forKey: UserDefaultConstants.sessionIDLogin)
            UserDefaults.standard.removeObject(forKey: UserDefaultConstants.userIDKeyLogin)
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
        }))
            
        alert.addAction(UIAlertAction(title: UIConstants.Dashboard.BottomAlert_Button_cancel, style: .cancel, handler:{ (UIAlertAction) in

        }))

        let image = UIImage.Icon.profile.image
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame =  CGRect(x: 50, y: 80, width: 26, height: 24)
        alert.view.addSubview(imageView)

        let image1 = UIImage.Icon.favorite.image
        let imageView1 = UIImageView()
        imageView1.image = image1
        imageView1.tintColor = .red
        alert.view.addSubview(imageView1)
        imageView1.frame = CGRect(x: 50, y: 137, width: 26, height: 24)
        

        self.present(alert, animated: true)
    }
    
    func selectBtn(index: Int) {
        presenter?.refresh(index: index)
    }
    
}

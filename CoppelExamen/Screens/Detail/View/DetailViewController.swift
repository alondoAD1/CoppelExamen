//
//  DetailViewController.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 11/02/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var data: ResultCustomModel?
    var uiDetail: UIDetailMovie = UIDetailMovie()
    var favoriteList = [FavoriteModel]()
    
    init(data: ResultCustomModel, dataFavorite: [FavoriteModel]) {
        super.init(nibName: nil, bundle: nil)
        self.data = data
        
        DispatchQueue.main.async {
            if dataFavorite.contains(where: { $0.id == data.id }) {
                self.view.backgroundColor = .red
            } else {
                self.view.backgroundColor = UIColor(colorIdentifier: .background)
            }
        }
    }
    
    deinit {
        data = nil
        favoriteList = []
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data = self.data else { return }
        uiDetail.setData(data: data)
        uiDetail.setLayoutConstraint(view: view)
        uiDetail.loadTVVideo(idTV: String(data.id))
        uiDetail.viewReproductor.frame = uiDetail.viewReproductor.frame
        uiDetail.viewReproductor.navigationDelegate = self

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        uiDetail.viewReproductor.stopLoading()
        uiDetail.viewReproductor.configuration.userContentController.removeScriptMessageHandler(forName: "...")
        uiDetail.viewReproductor.navigationDelegate = nil

    }

}

//
//  DetailViewController.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 11/02/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
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
        uiDetail.loadTVVideo(idTV: String(data.id)) { url in
            var mywkwebview: WKWebView?
            let mywkwebviewConfig = WKWebViewConfiguration()

            mywkwebviewConfig.allowsInlineMediaPlayback = true
            mywkwebview = WKWebView(frame: self.view.frame, configuration: mywkwebviewConfig)

            let myURL = URL(string: url)
            let youtubeRequest = URLRequest(url: myURL!)

            mywkwebview?.load(youtubeRequest)
        }

        uiDetail.loadVideo(navigation: navigationController!, id: "https://www.youtube.com/watch?v=\("u1DoR5-76Xc")")
        uiDetail.setData(data: data)
        uiDetail.setLayoutConstraint(view: view)
    }

}

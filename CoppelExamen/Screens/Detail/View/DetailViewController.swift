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
    
    init(data: ResultCustomModel) {
        super.init(nibName: nil, bundle: nil)
        self.data = data
    }
    
    deinit {
        data = nil
        favoriteList = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(colorIdentifier: .background)
        guard let data = self.data else { return }
        uiDetail.loadTVVideo(idTV: String(data.id)) { url in
//            guard let videoURL = URL(string: url) else { return }
//            var player = AVPlayer(url: videoURL)
//            self.ytPlayer = AVPlayerLayer(player: player)
//            self.ytPlayer.frame = self.view.bounds
//            self.ytPlayer.videoGravity = .resizeAspect
//            self.view.layer.addSublayer(self.ytPlayer)
//            player.play()
            
            var mywkwebview: WKWebView?
            let mywkwebviewConfig = WKWebViewConfiguration()

            mywkwebviewConfig.allowsInlineMediaPlayback = true
            mywkwebview = WKWebView(frame: self.view.frame, configuration: mywkwebviewConfig)

            let myURL = URL(string: url)
            let youtubeRequest = URLRequest(url: myURL!)

            mywkwebview?.load(youtubeRequest)
        }

        uiDetail.setData(data: data)
        uiDetail.setLayoutConstraint(view: view)
    }

}

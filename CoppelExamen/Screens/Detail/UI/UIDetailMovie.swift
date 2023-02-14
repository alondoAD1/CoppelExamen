//
//  UIDetailMovie.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 12/02/23.
//

import UIKit
import WebKit

class UIDetailMovie {
    
    var screenSize = UIScreen.main.bounds.size
    
    lazy var scrollViewDetaill: UIScrollView = create {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var imageBackgroundPath: UIImageView = create {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var effectView: UIView = create {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor(colorIdentifier: .background)?.withAlphaComponent(1).cgColor ?? UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y : 0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.85)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 300)
        $0.layer.insertSublayer(gradientLayer, at: 0)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var imagePosterPath: UIImageView = create {
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var titulo: UILabel = create {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.textColor = UIColor(colorIdentifier: .textSecundary)
        $0.font = .systemFont(ofSize: 26)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var date: UILabel = create {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.textColor = UIColor(colorIdentifier: .textSecundary)
        $0.font = .systemFont(ofSize: 20)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var vote_average: UILabel = create {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = .systemFont(ofSize: 20)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var overview: UILabel = create {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = .systemFont(ofSize: 22)
        $0.textAlignment = .justified
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var viewReproductor: WKWebView = create {
        $0.isUserInteractionEnabled = true
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.backgroundColor = .black
        $0.isOpaque = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var imagenReproductor: UIImageView = create {
        $0.contentMode = .scaleToFill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var imgReproducir: UIActivityIndicatorView = create {
        $0.style = .large
        $0.startAnimating()
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    func setLayoutConstraint(view: UIView) {
        view.addSubview(scrollViewDetaill)
        self.scrollViewDetaill.addSubview(imageBackgroundPath)
        self.scrollViewDetaill.addSubview(effectView)
        self.scrollViewDetaill.addSubview(imagePosterPath)
        self.scrollViewDetaill.addSubview(titulo)
        self.scrollViewDetaill.addSubview(date)
        self.scrollViewDetaill.addSubview(vote_average)
        self.scrollViewDetaill.addSubview(viewReproductor)
        self.scrollViewDetaill.addSubview(overview)
        
        self.viewReproductor.addSubview(imgReproducir)
        self.viewReproductor.addSubview(imagenReproductor)


        NSLayoutConstraint.activate([
            scrollViewDetaill.topAnchor.constraint(equalTo: view.topAnchor),
            scrollViewDetaill.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollViewDetaill.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollViewDetaill.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageBackgroundPath.topAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.topAnchor, constant: 0),
            imageBackgroundPath.leftAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.leftAnchor, constant: 0),
            imageBackgroundPath.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: 0),
            imageBackgroundPath.heightAnchor.constraint(equalToConstant: 300),
            
            effectView.topAnchor.constraint(equalTo: imageBackgroundPath.topAnchor),
            effectView.leftAnchor.constraint(equalTo: imageBackgroundPath.leftAnchor),
            effectView.rightAnchor.constraint(equalTo: imageBackgroundPath.rightAnchor),
            effectView.bottomAnchor.constraint(equalTo: imageBackgroundPath.bottomAnchor),

            imagePosterPath.topAnchor.constraint(equalTo: scrollViewDetaill.topAnchor, constant: 70),
            imagePosterPath.leftAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.leftAnchor, constant: 15),
            imagePosterPath.heightAnchor.constraint(equalToConstant: 200),
            imagePosterPath.widthAnchor.constraint(equalToConstant: 130),
            
            titulo.topAnchor.constraint(equalTo: scrollViewDetaill.topAnchor, constant: 70),
            titulo.leftAnchor.constraint(equalTo: imagePosterPath.rightAnchor, constant: 20),
            titulo.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            date.topAnchor.constraint(equalTo: titulo.bottomAnchor, constant: 15),
            date.leftAnchor.constraint(equalTo: imagePosterPath.rightAnchor, constant: 20),
            date.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            vote_average.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 10),
            vote_average.leftAnchor.constraint(equalTo: imagePosterPath.rightAnchor, constant: 20),
            vote_average.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            viewReproductor.topAnchor.constraint(equalTo: imagePosterPath.bottomAnchor, constant: 20),
            viewReproductor.leftAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.leftAnchor, constant: 15),
            viewReproductor.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: -15),
            viewReproductor.heightAnchor.constraint(equalToConstant: 250),
            
            imagenReproductor.topAnchor.constraint(equalTo: viewReproductor.topAnchor),
            imagenReproductor.leftAnchor.constraint(equalTo: viewReproductor.leftAnchor),
            imagenReproductor.rightAnchor.constraint(equalTo: viewReproductor.rightAnchor),
            imagenReproductor.bottomAnchor.constraint(equalTo: viewReproductor.bottomAnchor),

            imgReproducir.centerXAnchor.constraint(equalTo: viewReproductor.centerXAnchor),
            imgReproducir.centerYAnchor.constraint(equalTo: viewReproductor.centerYAnchor),
                        
            overview.topAnchor.constraint(equalTo: viewReproductor.bottomAnchor, constant: 20),
            overview.leftAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.leftAnchor, constant: 15),
            overview.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: -15),
            overview.bottomAnchor.constraint(equalTo: scrollViewDetaill.bottomAnchor, constant: -20),
        ])
    }

    func setData(data: ResultCustomModel) {
        let urlbackdrop = NetworkConstants.endPoint.LoadImages(id: data.backdropPath ?? "").url
        let urlpost = NetworkConstants.endPoint.LoadImages(id: data.posterPath ?? "").url
                   
        imageBackgroundPath.loadimagenUsandoCacheConURLString(urlString: urlbackdrop)
        imagePosterPath.loadimagenUsandoCacheConURLString(urlString: urlpost)
                
        titulo.text = data.name
        date.text = data.firstAirDate
        vote_average.text = String(data.voteAverage).appending(UIConstants.DetailMovie.VoteAverage)
        overview.text = UIConstants.DetailMovie.Override.appending(data.overview)
    }
    
    func loadTVVideo(idTV: String) {
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: NetworkConstants.endPoint.LoadVideos(id: idTV).url)!)) {
            (data, req, error) in
            do {
                let result = try JSONDecoder().decode(MovieTrailer.self, from: data!)

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if result.results.count == 0 { self.removeLoder() } else {
                        if let key = result.results[0].key {
                            self.playTrailer(videoID: NetworkConstants.endPoint.PlayVideo(id: key).url)
                        }
                    }
                }
            } catch {
                self.removeLoder()
            }
        }.resume()
    }
    
    func playTrailer(videoID: String) {
        DispatchQueue.main.async {
            guard let url = URL(string: videoID) else { return }
            var request = URLRequest(url: url)
            self.viewReproductor.load(request)
            self.removeLoder()
        }
    }
    
    func removeLoder() {
        imgReproducir.stopAnimating()
        imgReproducir.removeFromSuperview()
    }
    
}

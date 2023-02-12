//
//  UIDetailMovie.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 12/02/23.
//

import UIKit
import AVFoundation

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
    
    lazy var viewReproductor: UIView = create {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var imagenReproductor: UIImageView = create {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var imgReproducir: UIButtonCustom = create {
        $0.contentMode = .scaleToFill
        $0.setImage(UIImage.Icon.play.image, for: .normal)
        $0.tintColor = .white
        $0.isUserInteractionEnabled = true
        $0.isHidden = false
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
        
        self.viewReproductor.addSubview(imagenReproductor)
        self.viewReproductor.addSubview(imgReproducir)
        self.imageBackgroundPath.alpha = 0.35

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
            imgReproducir.heightAnchor.constraint(equalToConstant: 150),
            imgReproducir.widthAnchor.constraint(equalToConstant: 150),
                        
            overview.topAnchor.constraint(equalTo: viewReproductor.bottomAnchor, constant: 20),
            overview.leftAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.leftAnchor, constant: 15),
            overview.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: -15),
            overview.bottomAnchor.constraint(equalTo: scrollViewDetaill.bottomAnchor, constant: -20),
        ])
        
        imgReproducir.addTapGesture {

        }
    }

    func setData(data: ResultCustomModel) {
        let urlbackdrop = NetworkConstants.imagePath.appending(data.backdropPath ?? String())
        let urlpost = NetworkConstants.imagePath.appending(data.posterPath ?? String())
                   
        imageBackgroundPath.loadimagenUsandoCacheConURLString(urlString: urlbackdrop)
        imagePosterPath.loadimagenUsandoCacheConURLString(urlString: urlpost)
                
        titulo.text = data.name
        date.text = data.firstAirDate
        vote_average.text = String(data.voteAverage).appending(UIConstants.DetailMovie.VoteAverage)
        overview.text = UIConstants.DetailMovie.Override.appending(data.overview)
    }
    
    func loadTVVideo(idTV: String, completion: @escaping (String) -> Void) {
        let videoUrl = "https://api.themoviedb.org/3/movie/\(String(idTV))/videos?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"

        URLSession.shared.dataTask(with: URLRequest(url: URL(string: videoUrl)!)) {
            (data, req, error) in
            do {
                let result = try JSONDecoder().decode(MovieTrailer.self, from: data!)

                DispatchQueue.main.async {
                    for i in 0..<result.results.count{
                        let type = result.results[i].type
                        if type == "Trailer" {
                            let imgUrlKey = result.results[0].key!
                            let url = "https://i.ytimg.com/vi/\(imgUrlKey)/sddefault.jpg"
//                            self.ytPlayer.load(withVideoId: imgUrlKey)

                            self.imagenReproductor.loadimagenUsandoCacheConURLString(urlString: url)
                            self.playTrailer(videoID: imgUrlKey, completion: completion)
                        }
                    }
                }
            } catch {
                
            }
        }.resume()
    }
    
    func playTrailer(videoID: String, completion: @escaping (String) -> Void) {
        completion("https://www.youtube.com/watch?v=\(videoID)")
    }
    
}

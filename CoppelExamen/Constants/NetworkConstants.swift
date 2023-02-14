//
//  ServicePath.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 09/02/23.
//

import Foundation

struct NetworkConstants {
    
    static private var  getTokenMethod: String {
        return "authentication/token/new"
    }
    
    static private var apiKey: String {
        return "?api_key=7662169d6cde796d24b257cd0f8a268e"
    }
    
    static private var requestToken: String {
        return ""
    }
    
    static private var loginMethod: String {
        return "authentication/token/validate_with_login"
    }
    
    static private var sessionID: String {
        return "authentication/session/new"
    }
    
    static private var userAccount: String {
        return "account"
    }
    
    static private var sessionPost: String {
        return "&session_id="
    }
    
    static private var popular: String {
        return "tv/popular"
    }
    
    static private var tv: String {
        return "movie/"
    }
    
    static private var videos: String {
        return "/videos"
    }
    
    static private var topRated: String {
        return "tv/top_rated"
    }
    
    static private var onTheAir: String {
        return "tv/on_the_air"
    }
    
    static private var airingToday: String {
        return "tv/airing_today"
    }
    
    static private var lenguaje: String {
        return "&language=en-US"
    }
    
    static private var configApi: String {
        return "&language=en-US&page="
    }
    
    static private var imagePath: String {
        return "https://image.tmdb.org/t/p/w300"
    }

    static private var myImageProfile: String {
        return "https://www.themoviedb.org/t/p/w150_and_h150_face/zuUrxOM7ywKWAEcJB02DcbQEccS.jpg"
    }
    
    
    enum endPoint {
        case TVPopular(nextPage: String)
        case TVRated(nextPage: String)
        case TVOntv(nextPage: String)
        case TVAirToday(nextPage: String)
        case AccountData(id: String)
        case MyFavorite
        case SessionID
        case LoginToken
        case DataLogin
        case ImageProfile
        case LoadImages(id: String)
        case LoadVideos(id: String)
        case PlayVideo(id: String)
        
        var url: String {
            switch self {
            case .TVPopular(let page):
                return popular.appending(apiKey).appending(configApi).appending(page)
            case .TVRated(let page):
                return topRated.appending(apiKey).appending(configApi).appending(page)
            case .TVOntv(let page):
                return onTheAir.appending(apiKey).appending(configApi).appending(page)
            case .TVAirToday(let page):
                return airingToday.appending(apiKey).appending(configApi).appending(page)
            case .AccountData(let id):
                return userAccount.appending(apiKey).appending(sessionPost).appending(id)
            case .MyFavorite:
                return "urlFavorite"
            case .SessionID:
                return sessionID.appending(apiKey)
            case .LoginToken:
                return loginMethod.appending(apiKey)
            case .DataLogin:
                return getTokenMethod.appending(apiKey)
            case .ImageProfile:
                return myImageProfile
            case .LoadImages(let url):
                return imagePath.appending(url)
            case .LoadVideos(let id):
                return "https://api.themoviedb.org/3/tv/\(String(id))/videos?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"
            case .PlayVideo(let url):
                return "https://www.youtube.com/embed/".appending(url)
            }
        }
    }
    
}

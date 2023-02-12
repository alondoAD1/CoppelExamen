//
//  ServicePath.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 09/02/23.
//

import Foundation

struct NetworkConstants {
        
    static var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    static var  getTokenMethod: String {
        return "authentication/token/new"
    }
    
    static var apiKey: String {
        return "?api_key=7662169d6cde796d24b257cd0f8a268e"
    }
    
    static var requestToken: String {
        return ""
    }
    
    static var loginMethod: String {
        return "authentication/token/validate_with_login"
    }
    
    static var sessionID: String {
        return "authentication/session/new"
    }
    
    static var userAccount: String {
        return "account"
    }
    
    static var sessionPost: String {
        return "&session_id="
    }
    
    static var popular: String {
        return "tv/popular"
    }
    
    static var tv: String {
        return "movie/"
    }
    
    static var videos: String {
        return "/videos"
    }
    
    static var topRated: String {
        return "tv/top_rated"
    }
    
    static var onTheAir: String {
        return "tv/on_the_air"
    }
    
    static var airingToday: String {
        return "tv/airing_today"
    }
    
    static var lenguaje: String {
        return "&language=en-US"
    }
    
    static var configApi: String {
        return "&language=en-US&page="
    }
    
    static var imagePath: String {
        return "https://image.tmdb.org/t/p/w300"
    }

    static var myImageProfile: String {
        return "https://www.themoviedb.org/t/p/w150_and_h150_face/zuUrxOM7ywKWAEcJB02DcbQEccS.jpg"
    }
    

}

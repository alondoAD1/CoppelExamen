//
//  DashboardModel.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import Foundation

struct DashboardModel: Codable {
    let page: Int?
    let results: [ResultModel]?
    let totalResults, totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct ResultModel: Codable {
    let posterPath: String?
    let popularity: Double
    let id: Int
    let backdropPath: String?
    let voteAverage: Double
    let overview, firstAirDate: String
    let originCountry: [String]
    let genreIDS: [Int]
    let originalLanguage: String
    let voteCount: Int
    let name, originalName: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity, id
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
    }
}

//MARK: CustomModel Favorite
struct DashboardCustomModel: Codable {
    let page: Int?
    let results: [ResultCustomModel]?
    let totalResults, totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }

}

// MARK: CustomResult
struct ResultCustomModel: Codable {
    let posterPath: String?
    let popularity: Double
    let id: Int
    let backdropPath: String?
    let voteAverage: Double
    let overview, firstAirDate: String
    let originCountry: [String]
    let genreIDS: [Int]
    let originalLanguage: String
    let voteCount: Int
    let name, originalName: String
    let isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity, id
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case isFavorite
    }
}


public struct FavoriteModel: Codable {
    let posterPath: String?
    let popularity: Double
    let id: Int
    let backdropPath: String?
    let voteAverage: Double
    let overview, firstAirDate: String
    let originCountry: [String]
    let genreIDS: [Int]
    let originalLanguage: String
    let voteCount: Int
    let name, originalName: String
    let isFavorite: Bool?
    
    public init(posterPath: String? = String(), popularity: Double = Double(), id: Int = Int(), backdropPath: String? = String(), voteAverage: Double = Double(), overview: String = String(), firstAirDate: String = String(), originCountry: [String] = [String()], genreIDS: [Int] = [Int()], originalLanguage: String = String(), voteCount: Int = Int(), name: String = String(), originalName: String = String(), isFavorite: Bool? = Bool()) {
        self.posterPath = posterPath
        self.popularity = popularity
        self.id = id
        self.backdropPath = backdropPath
        self.voteAverage = voteAverage
        self.overview = overview
        self.firstAirDate = firstAirDate
        self.originCountry = originCountry
        self.genreIDS = genreIDS
        self.originalLanguage = originalLanguage
        self.voteCount = voteCount
        self.name = name
        self.originalName = originalName
        self.isFavorite = isFavorite
    }

}

struct MovieTrailer: Decodable {
    let id: Int?
    let results: [MovieTrailerresult]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"

    }
    
}

struct MovieTrailerresult: Decodable {
    let iso_639_1: String?
    let iso_3166_1: String?
    let name: String?
    let key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let published_at: String?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case iso_639_1 = "iso_639_1"
        case iso_3166_1 = "iso_3166_1"
        case name = "name"
        case key = "key"
        case site = "site"
        case size = "size"
        case type = "type"
        case official = "official"
        case published_at = "published_at"
        case id = "id"

    }
    
}

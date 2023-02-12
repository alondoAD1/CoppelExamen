//
//  ModelLogin.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import Foundation

struct baseServiceModel: Codable {
    let success: Bool
    let expiresAt, requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

struct objectPostLogin: Codable {
    let username: String
    let password: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case requestToken = "request_token"
    }
}

struct withLoginModel: Decodable {
    let username: String
    let password: String
    let request_token: String
}

struct objSessionIDLoginModel: Codable {
    let success: Bool
    let sessionid: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case sessionid = "session_id"
    }
}

struct ModelLogin: Codable {
    var avatar: Avatar?
    var id: Int?
    var iso6391, iso31661, name: String?
    var includeAdult: Bool?
    var username: String?
    
    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let gravatar: Gravatar
}

// MARK: - Gravatar
struct Gravatar: Codable {
    let hash: String
}

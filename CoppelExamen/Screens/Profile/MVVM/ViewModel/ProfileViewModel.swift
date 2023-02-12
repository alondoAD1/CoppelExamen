//
//  ProfileViewModel.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 12/02/23.
//

import UIKit

class ProfileViewModel {
    
    var refreshDataLogin = { () -> () in }
    var dataLogin: [ModelLogin] = [] {
        didSet {
            refreshDataLogin()
        }
    }
    
    var refreshFavorite = { () -> () in }
    var arrayFavorite: [FavoriteModel] = [] {
        didSet {
            refreshFavorite()
        }
    }
    
    func userAccount() async throws  {
        
        let endPoint = NetworkConstants.userAccount.appending(NetworkConstants.apiKey).appending(NetworkConstants.sessionPost).appending(UserDefaults.standard.string(forKey: UserDefaultConstants.sessionIDLogin) ?? String())
        do {
            let data = try await NetworkingService.request(endPoint: endPoint, model: ModelLogin.self, method: .GET)
            dataLogin = [data]
        } catch {
            throw error
        }

    }
    
    func getMyFavorite() async throws {
        var reloadFavorite: [FavoriteModel] = []
        let decoder = JSONDecoder()
        if let codedReloadContacts = UserDefaults.standard.value(forKey: UserDefaultConstants.favoriteList) as? Data {
            reloadFavorite = try! decoder.decode(Array.self, from: codedReloadContacts) as [FavoriteModel]
        }
        arrayFavorite = reloadFavorite
    }
    
    
    
}

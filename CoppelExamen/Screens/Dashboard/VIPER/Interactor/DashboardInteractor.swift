//
//  DashboardInteractor.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import Foundation

class DashboardInteractor: PresenterToInteractorDashboardProtocol {

    weak var presenter: InteractorToPresenterDashboardProtocol?

    func getTV_Popular() async throws -> [DashboardCustomModel] {
        let endPoint = NetworkConstants.popular.appending(NetworkConstants.apiKey).appending(NetworkConstants.configApi).appending("1")
        do {
            let data = try await NetworkingService.request(endPoint: endPoint, model: DashboardCustomModel.self, method: .GET)
            return [data]
        } catch { throw error }
    }
    
    func getTV_TopRated() async throws -> [DashboardCustomModel] {
        let endPoint = NetworkConstants.topRated.appending(NetworkConstants.apiKey).appending(NetworkConstants.configApi).appending("1")
        do {
            let data = try await NetworkingService.request(endPoint: endPoint, model: DashboardCustomModel.self, method: .GET)
            return [data]
        } catch { throw error }
                
    }
    
    func getTV_OnTv() async throws -> [DashboardCustomModel] {
        let endPoint = NetworkConstants.onTheAir.appending(NetworkConstants.apiKey).appending(NetworkConstants.configApi).appending("1")
        do {
            let data = try await NetworkingService.request(endPoint: endPoint, model: DashboardCustomModel.self, method: .GET)
            return [data]
        } catch { throw error }
    }
    
    func getTV_AringToday() async throws -> [DashboardCustomModel] {
        let endPoint = NetworkConstants.airingToday.appending(NetworkConstants.apiKey).appending(NetworkConstants.configApi).appending("1")
        do {
            let data = try await NetworkingService.request(endPoint: endPoint, model: DashboardCustomModel.self, method: .GET)
            return [data]
        } catch { throw error }
    }
    
    func getAccountData(sessionID: String) async throws -> [ModelLogin] {
        let endPoint = NetworkConstants.userAccount.appending(NetworkConstants.apiKey).appending(NetworkConstants.sessionPost).appending(sessionID)
        do {
            let data = try await NetworkingService.request(endPoint: endPoint, model: ModelLogin.self, method: .GET)
            return [data]
        } catch { throw error }
    }
    
    func getMyFavorite() async throws -> [FavoriteModel] {
        var reloadFavorite: [FavoriteModel] = []
        let decoder = JSONDecoder()
        if let codedReloadContacts = UserDefaults.standard.value(forKey: UserDefaultConstants.favoriteList) as? Data {
            guard let favoriteDecoded = try? decoder.decode(Array.self, from: codedReloadContacts) as [FavoriteModel] else {
                return [FavoriteModel()]
            }

            reloadFavorite = favoriteDecoded
        }
        return reloadFavorite
    }
    
    func getMovieDetail(index: Int) {
//        arrayMoviews?[0][1].results
        //call api for detail
    }
    
    
    
    
}

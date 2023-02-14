//
//  DashboardInteractor.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import Foundation

class DashboardInteractor: PresenterToInteractorDashboardProtocol {

    weak var presenter: InteractorToPresenterDashboardProtocol?

    func getTV_Popular() async {
        do {
            let data = try await NetworkingService.request(endPoint: NetworkConstants.endPoint.TVPopular(nextPage: "1").url, model: DashboardCustomModel.self, method: .GET)
            presenter?.fetchTVPopularSuccess(data: [data])
        } catch {
            presenter?.fetchTVPopularFailure(error: error.localizedDescription)
        }
    }
    
    func getTV_TopRated() async {
        do {
            let data = try await NetworkingService.request(endPoint: NetworkConstants.endPoint.TVRated(nextPage: "1").url, model: DashboardCustomModel.self, method: .GET)
            presenter?.fetchTVPopularSuccess(data: [data])
        } catch {
            presenter?.fetchTVTopRatedFailure(error: error.localizedDescription)
        }
    }
    
    func getTV_OnTv() async {
        do {
            let data = try await NetworkingService.request(endPoint: NetworkConstants.endPoint.TVOntv(nextPage: "1").url, model: DashboardCustomModel.self, method: .GET)
            presenter?.fetchTVPopularSuccess(data: [data])
        } catch {
            presenter?.fetchTVOnTvFailure(error: error.localizedDescription)
        }
    }
    
    func getTV_AringToday() async {
        do {
            let data = try await NetworkingService.request(endPoint: NetworkConstants.endPoint.TVAirToday(nextPage: "1").url, model: DashboardCustomModel.self, method: .GET)
            presenter?.fetchTVPopularSuccess(data: [data])
        } catch {
            presenter?.fetchTVAiringTodayFailure(error: error.localizedDescription)
        }
    }
    
    func getAccountData(sessionID: String) async throws -> [ModelLogin] {
        do {
            let data = try await NetworkingService.request(endPoint: NetworkConstants.endPoint.AccountData(id: sessionID).url, model: ModelLogin.self, method: .GET)
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

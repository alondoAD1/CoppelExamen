//
//  ViewModelLogin.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import UIKit

class ViewModelLogin {
    
    var refreshDataLogin = { () -> () in }
    var dataLogin: [ModelLogin] = [] {
        didSet {
            refreshDataLogin()
        }
    }
    
    
    func getDataLogin(loader: UIAlertController,
                      username: String,
                      password: String,
                      completion: @escaping (Bool, String) -> Void) async throws {
        do {
            let data = try await NetworkingService.request(endPoint: NetworkConstants.endPoint.DataLogin.url, model: baseServiceModel.self, method: .GET)
            try await loginToken(requestToken: data.requestToken, username: username, password: password, loader: loader, completion: completion)
        } catch {
            completion(false, NetworkError.user_pass.rawValue)
            await loader.dismiss(animated: true)
            throw error
        }
        
    }
    
    func loginToken(requestToken: String,
                    username: String,
                    password: String,
                    loader: UIAlertController,
                    completion: @escaping (Bool, String) -> Void) async throws {
        
//    let parameters = ["request_token": requestToken,
//                      "username": "RicardoAD",
//                      "password": "123456789"]
        
        let parameters = ["request_token": requestToken,
                          "username": username,
                          "password": password]
        
        do {
            let data = try await NetworkingService.request(endPoint: NetworkConstants.endPoint.LoginToken.url, parameters: parameters, model: baseServiceModel.self, method: .POST)
            try await self.sessionID(requestToken: data.requestToken, loader: loader, completion: completion)
        } catch {
            completion(false, error.localizedDescription)
            await loader.dismiss(animated: true)
            throw error
        }

    }
    
    func sessionID(requestToken: String,
                   loader: UIAlertController,
                   completion: @escaping (Bool, String) -> Void) async throws  {
        do {
            let data = try await NetworkingService.request(endPoint: NetworkConstants.endPoint.SessionID.url, parameters: ["request_token": requestToken], model: objSessionIDLoginModel.self, method: .POST)
            try await userAccount(sessionID: data.sessionid, loader: loader, completion: completion)
        } catch {
            completion(false, error.localizedDescription)
            await loader.dismiss(animated: true)
            throw error
        }

}
    
    func userAccount(sessionID: String,
                     loader: UIAlertController,
                     completion: @escaping (Bool, String) -> Void) async throws  {
        do {
            let data = try await NetworkingService.request(endPoint: NetworkConstants.endPoint.AccountData(id: sessionID).url, model: ModelLogin.self, method: .GET)
            UserDefaults.standard.set(data.id, forKey: UserDefaultConstants.userIDKeyLogin)
            UserDefaults.standard.set(sessionID, forKey: UserDefaultConstants.sessionIDLogin)
            completion(true, String())
        } catch {
            completion(false, error.localizedDescription)
            await loader.dismiss(animated: true)
            throw error
        }

    }

}

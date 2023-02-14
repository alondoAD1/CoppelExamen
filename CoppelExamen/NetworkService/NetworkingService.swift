//
//  NetworkingService.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 09/02/23.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case HEAD = "HEAD"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case CONNECT = "CONNECT"
    case OPTIONS = "OPTIONS"
    case TRACE = "TRACE"
    case PATCH = "PATCH"
}

enum NetworkError: String, Error {
    case invalidURL
    case serializationFailed
    case generic
    case couldNotDecodeData
    case httpResponseError
    case statusCodeError = "Oucrrio un error al tratar de consultar el Api: status code"
    case jsonDecoder = "Error al intentar extraer datos del Json."
    case unauthorized
    case user_pass = "Invalid username and/or password. You did not provide a valid login."
}

@MainActor
class NetworkingService {
    
    public static var shared: NetworkingService = NetworkingService()
    private static let baseURL = "https://api.themoviedb.org/3/"
    
    static func request<T: Decodable>(endPoint: String,
                               parameters: [String: Any]? = nil,
                               model: T.Type,
                               method: HTTPMethod) async throws -> T {
        
        guard let url = URL(string: baseURL + endPoint) else {
            throw NetworkError.invalidURL
        }
        var json: [String: Any] = [:]
        json = ["api_key": "7662169d6cde796d24b257cd0f8a268e"]
        json = parameters ?? [:]
        let parameters = try? JSONSerialization.data(withJSONObject: json)
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if !(json.isEmpty) { request.httpBody = parameters }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.httpResponseError
            }
            
            if httpResponse.statusCode > 299 { throw NetworkError.statusCodeError }
            
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(T.self, from: data)
                return decodeData
            } catch { throw NetworkError.couldNotDecodeData }
        } catch { throw NetworkError.generic }
        
    }
    
}

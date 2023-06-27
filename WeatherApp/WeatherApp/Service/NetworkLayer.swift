//
//  NetworkLayer.swift
//  WeatherApp
//
//  Created by Rohith Raju on 6/23/23.
//

import Foundation

protocol NetworkProtocol {
    func fetchWeather(locationName: String) async throws -> Result<Weather, NetworkError>
}

class NetworkLayer: NetworkProtocol {
    
    static let shared = NetworkLayer()
    let baseURL: String = "http://api.weatherapi.com/v1/current.json"
    let APIKey = "ebb67604775d4e9badf141831232306"
    
    public func fetchWeather(locationName: String) async throws -> Result<Weather, NetworkError> {
        
        let fullURLStr = baseURL + "?key=" + APIKey
        
        let queryItems = [URLQueryItem(name: "q", value: locationName)]
        let url = URL(string: fullURLStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        if let url = url?.appending(queryItems: queryItems) {
            let request = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: request)
            do {
                let fetchedData = try JSONDecoder().decode(Weather.self, from: try mapResponse(response: (data,response)))
                return .success(fetchedData)
            } catch {
                if let error = error as? NetworkError {
                    return .failure(error)
                } else {
                    print(error)
                }
            }
        }
        return .failure(.badRequest)
    }
    
    func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return response.data
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        case 402:
            throw NetworkError.paymentRequired
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        case 413:
            throw NetworkError.requestEntityTooLarge
        case 422:
            throw NetworkError.unprocessableEntity
        default:
            throw NetworkError.http(httpResponse: httpResponse, data: response.data)
        }
    }
    
}

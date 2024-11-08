//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Rohith Raju on 6/23/23.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var locationName: String = ""
    @Published var tempCelsius: String = ""
    @Published var tempFarah: String = ""
    @Published  var cityName: String = ""
    @Published var showWeatherData: Bool = false
    var weatherData: Weather? = nil
    var webService: NetworkProtocol

    init(webService: NetworkProtocol) {
        self.webService = webService
    }
    
    @MainActor
    func getWeatherData() {
        Task {
            do{
                let result: Weather = try await webService.fetchWeather(locationName: cityName)
                weatherData = result
                mappingOntoView(weather: weatherData)
            } catch{
                print(error)
            }
        }
    }
    
    @MainActor
    func mappingOntoView(weather: Weather?) {
        guard let weatherUnwrapped: Weather = weather else {
           return
        }
        locationName = weatherUnwrapped.location.name
        tempCelsius = "\(String(describing: weatherUnwrapped.current.tempC))"
        tempFarah = "\(String(describing: weatherUnwrapped.current.tempF))"
        showWeatherData = true
    }
}

//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Rohith Raju on 6/23/23.
//

import Foundation

@Observable class WeatherViewModel {
    var locationName: String = ""
    var tempCelsius: String = ""
    var tempFarah: String = ""
    var cityName: String = ""
    var showWeatherData: Bool = false
    
    var weatherData: Weather? = nil
    var webService: NetworkProtocol

    init(webService: NetworkProtocol) {
        self.webService = webService
    }
    
    @MainActor
    func getWeatherData() async {
        do{
            let result: Weather = try await webService.fetchWeather(locationName: cityName)
            weatherData = result
            mappingOntoView(weather: weatherData)
        } catch{
            print(error)
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

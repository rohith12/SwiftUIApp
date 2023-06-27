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
    
    @MainActor
    func getWeatherData() {
        Task{
            do{
                weatherData = try await NetworkLayer.shared.fetchWeather(locationName: cityName)
                if let weather = weatherData {
                    locationName = weather.location.name
                    tempCelsius = "\(weather.current.tempC)"
                    tempFarah = "\(weather.current.tempF)"
                    showWeatherData = true
                }
            }catch{
                print(error)
            }
        }
    }
}

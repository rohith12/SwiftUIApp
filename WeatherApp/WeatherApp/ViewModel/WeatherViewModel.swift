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
                let result = try await NetworkLayer.shared.fetchWeather(locationName: cityName)
                switch result {
                case .success(let weather):
                    weatherData = weather
                    locationName = weather.location.name
                    tempCelsius = "\(weather.current.tempC)"
                    tempFarah = "\(weather.current.tempF)"
                    showWeatherData = true
                case .failure(let error):
                    print(error)
                }
                
            }catch{
                print(error)
            }
        }
    }
}

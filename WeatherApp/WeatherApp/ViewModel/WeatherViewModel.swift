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
    var weatherData: Weather? = nil
    @MainActor
    func getWeatherData() {
        Task{
            do{
                weatherData = try await NetworkLayer.shared.fetchWeather()
                if let weather = weatherData {
                    locationName = weather.location.name
                    tempCelsius = "\(weather.current.tempC)"
                    tempFarah = "\(weather.current.tempF)"
                }
            }catch{
                print(error)
            }
        }
    }
}

//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Rohith Raju on 6/25/23.
//

import SwiftUI

struct WeatherDetailView: View {
    
    var weatherData: Weather
    
    init(_ weather: Weather) {
        weatherData = weather
    }
    
    var body: some View {
        displayWeatherData()
            .padding()
        Spacer()
    }
    
    @ViewBuilder func displayWeatherData() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Location name: ")
                Text(weatherData.location.name)
            }
            HStack {
                Text("Location time: ")
                Text(weatherData.location.localtime)
            }
            HStack {
                Text("Country: ")
                Text(weatherData.location.country)
            }
            HStack {
                Text("Temp celsius: ")
                Text("\(weatherData.current.tempC)")
            }
            HStack {
                Text("feelslikeC: ")
                Text("\(weatherData.current.tempF)")
            }
            HStack {
                Text("feels like celsius: ")
                Text("\(weatherData.current.feelslikeC)")
            }
            HStack {
                Text("feels like fahrenheit: ")
                Text("\(weatherData.current.feelslikeF)")
            }
        }
    }
}



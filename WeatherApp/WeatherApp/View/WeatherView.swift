//
//  ContentView.swift
//  WeatherApp
//
//  Created by Rohith Raju on 6/23/23.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var viewModel = WeatherViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                fetchWeatherData()
                    .padding(10)
                displayWeatherData()
                    .padding(10)
                Spacer()
            }
        }
        .navigationTitle("Weather App")
    }
    
    @ViewBuilder func fetchWeatherData() -> some View {
        VStack(alignment: .center) {
            TextField("Enter city name or zipcode", text: $viewModel.cityName)
            Button("Get weather data") {
                if viewModel.cityName.count > 0 {
                    viewModel.getWeatherData()
                }
            }
        }
    }
    
    @ViewBuilder func displayWeatherData() -> some View {
        if viewModel.showWeatherData {
            VStack(alignment: .leading) {
                HStack {
                    Text("Location name: ")
                    Text(viewModel.locationName)
                }
                HStack {
                    Text("Temp celsius: ")
                    Text(viewModel.tempCelsius)
                }
                HStack {
                    Text("Temp Fahrenheit: ")
                    Text(viewModel.tempFarah)
                }
                Spacer()
                NavigationLink {
                    if let weatherData = viewModel.weatherData {
                        WeatherDetailView(weatherData)
                    }
                } label : {
                    Text("Weather Detail")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

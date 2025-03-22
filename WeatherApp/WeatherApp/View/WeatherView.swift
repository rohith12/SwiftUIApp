//
//  ContentView.swift
//  WeatherApp
//
//  Created by Rohith Raju on 6/23/23.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject var viewModel = WeatherViewModel(webService: NetworkLayer.shared)

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
                    Task {
                        await viewModel.getWeatherData()
                    }
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

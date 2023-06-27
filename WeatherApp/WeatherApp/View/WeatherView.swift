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
                displayWeatherData()
                Spacer()
                NavigationLink {
                    if let weatherData = viewModel.weatherData {
                        WeatherDetailView(weatherData)
                    }
                } label : {
                    Text("Weather Detail")
                }
            }
            .onAppear {
                viewModel.getWeatherData()
            }
            .padding()
        }
        .navigationTitle("Weather App")
    }
    
    @ViewBuilder func displayWeatherData() -> some View {
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
        }
    }
}

enum NavigationState {
    case screen1
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

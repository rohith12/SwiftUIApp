//
//  ContentView.swift
//  WeatherApp
//
//  Created by Rohith Raju on 6/23/23.
//

import SwiftUI

struct WeatherWatch: View {
    
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
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
        .onAppear {
            viewModel.getWeatherData()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWatch()
    }
}

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
            Text(viewModel.locationName)
            Text(viewModel.tempCelsius)
            Text(viewModel.tempFarah)
        }.onAppear {
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

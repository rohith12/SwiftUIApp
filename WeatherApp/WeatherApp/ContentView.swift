//
//  ContentView.swift
//  WeatherApp
//
//  Created by Rohith Raju on 6/23/23.
//

import SwiftUI

struct WeatherWatch: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWatch()
    }
}

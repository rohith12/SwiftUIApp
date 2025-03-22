//
//  WeatherViewModelTest.swift
//  WeatherApp
//
//  Created by Rohith Raju on 3/22/25.
//

import Testing
@testable import WeatherApp

struct WeatherViewModelTest {
    @MainActor @Test("Test Weather Data and UI updates")
    func getWeatherData() async throws {
        let viewModel = WeatherViewModel(webService: MockNetworkLayer())
        await viewModel.getWeatherData()
        try #require(viewModel.weatherData != nil)
        #expect(viewModel.showWeatherData == true)
        #expect(viewModel.weatherData?.location.name == "Dallas")
    }
}


struct MockNetworkLayer: NetworkProtocol {
    func fetchWeather(locationName: String) async throws -> Weather {
        let weatherModel: Weather = Weather(location: Location(name: "Dallas", region: "", country: "USA", lat: 90, lon: 90, tzID: "", localtimeEpoch: 0, localtime: ""), current: Current(lastUpdatedEpoch: 0, lastUpdated: "0", tempC: 35, tempF: 89, isDay: 1, condition: Condition(text: "", icon: "", code: 0), windMph: 0, windKph: 0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0, visKM: 0, visMiles: 0, uv: 0, gustMph: 0, gustKph: 0))
        return weatherModel
    }
}

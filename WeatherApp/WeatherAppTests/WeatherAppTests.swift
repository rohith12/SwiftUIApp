//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Rohith Raju on 6/23/23.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    
    var viewModel: WeatherViewModel! = nil

    override func setUpWithError() throws {
        viewModel = WeatherViewModel(webService: MockNetworkLayer())
    }

    override func tearDownWithError() throws {
       viewModel = nil
    }
    
    @MainActor 
    func testGetWeatherData() async {
        viewModel.getWeatherData()
        let getWeatherData: XCTNSPredicateExpectation = XCTNSPredicateExpectation(predicate: NSPredicate(block: { _, _ in
            self.viewModel.weatherData != nil
        }), object: nil)
        await fulfillment(of: [getWeatherData], timeout: 5)
        XCTAssertNotNil(viewModel.weatherData)
        XCTAssertEqual(viewModel.locationName, "Dallas")
        XCTAssertEqual(viewModel.tempCelsius, "35.0")
        XCTAssertEqual(viewModel.tempFarah, "89.0")
    }
}

class MockNetworkLayer: NetworkProtocol {
    func fetchWeather(locationName: String) async throws -> Result<Weather, NetworkError> {
        let weatherModel: Weather = Weather(location: Location(name: "Dallas", region: "", country: "USA", lat: 90, lon: 90, tzID: "", localtimeEpoch: 0, localtime: ""), current: Current(lastUpdatedEpoch: 0, lastUpdated: "0", tempC: 35, tempF: 89, isDay: 1, condition: Condition(text: "", icon: "", code: 0), windMph: 0, windKph: 0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0, visKM: 0, visMiles: 0, uv: 0, gustMph: 0, gustKph: 0))
        return .success(weatherModel)
    }
}

//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Paul Solt on 2/12/25.
//

import Foundation

enum WeatherError: Error {
    case invalidURL
}

struct WeatherService {

    func fetchWeather(city: String, state: String, countryCode: String) async throws {
        print("fetchWeather()")

        // TODO: Fix spaces in city/state/countryCode with % escaping
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city),\(state),\(countryCode)&appid=\(weatherAPIKey)"
        print(urlString)

        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)

        print(data)
        print(response)
    }
}

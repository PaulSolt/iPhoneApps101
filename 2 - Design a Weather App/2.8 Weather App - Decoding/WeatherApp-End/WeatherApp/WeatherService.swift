//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Paul Solt on 2/12/25.
//

import Foundation

enum WeatherError: Error {
    case invalidURL
    case invalidAPIKey
    case unknownLocation
    case invalidResponse(statusCode: Int)
}

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]

    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let humidity: Double
    }

    struct Weather: Codable {
        let description: String
        let icon: String
    }
}

struct WeatherService {

    func fetchWeather(city: String, state: String, countryCode: String) async throws -> WeatherData {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city),\(state),\(countryCode)&appid=\(weatherAPIKey)&units=imperial"

        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidURL
        }
        print(url)
        let (data, response) = try await URLSession.shared.data(from: url)

        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 401:
                throw WeatherError.invalidAPIKey
            case 404:
                throw WeatherError.unknownLocation
            case 200...299:
                print("Success! \(httpResponse.statusCode)")
            default:
                throw WeatherError.invalidResponse(statusCode: httpResponse.statusCode)
            }
        }

        print(data)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let weatherData = try decoder.decode(WeatherData.self, from: data)

        print(weatherData)

        return weatherData
    }
}

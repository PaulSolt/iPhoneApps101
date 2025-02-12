//
//  WeatherService.swift
//  WeatherApp-Demo
//
//  Created by Paul Solt on 2/9/25.
//

import Foundation

// Simple API Structure

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]

    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let humidity: Int
    }

    struct Weather: Codable {
        let description: String
        let icon: String
    }
}

// Swift Friendly names

enum WeatherError: Error {
    case invalidURL
    case invalidAPIKey
    case httpStatusCode(statusCode: Int)
}

struct WeatherService {
    func fetchWeather(city: String, state: String, country: String) async throws -> WeatherData? {
        //        let location = "\(city),\(state),\(country)"
        let location = [city, state, country]
            .filter { !$0.isEmpty }
            .joined(separator: ",")
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(location)&units=imperial&appid=\(weatherAPIKey)"
        print("urlString: \(urlString)")

        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 401:
                throw WeatherError.invalidAPIKey
            case 200...299:
                print("Success!: \(httpResponse.statusCode)")
            default:
                throw WeatherError.httpStatusCode(statusCode: httpResponse.statusCode)
            }
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let weatherData = try decoder.decode(WeatherData.self, from: data)

        print(weatherData)
        return weatherData

        // TODO: process DecodingError in the UI Layer so we can show proper error messages
    }
}


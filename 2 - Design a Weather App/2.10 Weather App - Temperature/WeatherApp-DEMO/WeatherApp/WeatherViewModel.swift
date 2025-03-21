//
//  WeatherViewModel.swift
//  WeatherApp-DEMO
//
//  Created by Paul Solt on 3/18/25.
//

import SwiftUI

enum TemperatureUnit: String, CaseIterable {
    case fahrenheit = "F"
    case celsius = "C"
    
    var symbol: String {
        rawValue
    }
}

@Observable
class WeatherViewModel {
    private let weatherService: WeatherService = WeatherService()

    // Location properties
    var city: String = "Rochester"
    var state: String = "NY"
    var country: String = "US"

    // Weather display properties
    var icon: String = "cloud.sun.fill"
    var cityName: String = "Rochester"
    var description: String = "Sunny"
    var temperature: String = "15.8ºF"
    var feelsLike: String = "Feels like: 5.9ºF"
    var humidity: String = "87% humidity"

    // Temperature unit
    var selectedUnit: TemperatureUnit = .fahrenheit {
        didSet {
            updateTemperatureDisplay()
        }
    }
    
    // Store raw values for conversion
    private var rawTemperature: Double?
    private var rawFeelsLike: Double?

    func fetchWeather() {
        Task {
            do {
                let weatherData = try await weatherService.fetchWeather(city: city, state: state, countryCode: country)

                if let weather = weatherData.weather.first {
                    icon = sfSymbolName(for: weather.icon)
                    description = weather.description.capitalized
                }
                
                // Store raw values
                rawTemperature = weatherData.main.temp
                rawFeelsLike = weatherData.main.feelsLike
                
                // Update displayed values
                updateTemperatureDisplay()
                
                humidity = "\(Int(weatherData.main.humidity))% Humidity"
                cityName = weatherData.name

            } catch {
                print("Error: \(error)")
                // TODO: API error or other errors (Show a banner)
            }
        }
    }
    
    private func updateTemperatureDisplay() {
        guard let rawTemp = rawTemperature,
              let rawFeels = rawFeelsLike else { return }
        
        let (tempValue, feelsValue) = selectedUnit == .celsius 
            ? (fahrenheitToCelsius(rawTemp), fahrenheitToCelsius(rawFeels))
            : (rawTemp, rawFeels)
        
        temperature = String(format: "%.1fº%@", tempValue, selectedUnit.symbol)
        feelsLike = String(format: "Feels like: %.1fº%@", feelsValue, selectedUnit.symbol)
    }
    
    private func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5/9
    }

    func sfSymbolName(for icon: String) -> String {
        switch icon {
        case "01d.png": // Clear sky (day)
            return "sun.max.fill"
        case "01n.png": // Clear sky (night)
            return "moon.stars.fill"
        case "02d.png": // Few clouds (day)
            return "cloud.sun.fill"
        case "02n.png": // Few clouds (night)
            return "cloud.moon.fill"
        case "03d.png", "03n.png": // Scattered clouds
            return "cloud.fill"
        case "04d.png", "04n.png": // Broken clouds (overcast)
            return "cloud.fill"
        case "09d.png", "09n.png": // Shower rain
            return "cloud.drizzle.fill"
        case "10d.png", "10n.png": // Rain
            return "cloud.rain.fill"
        case "11d.png", "11n.png": // Thunderstorm
            return "cloud.bolt.rain.fill"
        case "13d.png", "13n.png": // Snow
            return "cloud.snow.fill"
        case "50d.png", "50n.png": // Mist
            return "cloud.fog.fill"
        default:
            // Fallback symbol if none match
            return "cloud.fill"
        }
    }
}

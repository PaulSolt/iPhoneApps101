//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Paul Solt on 3/19/25.
//

import Observation

enum TemperatureUnit: String, CaseIterable {
    case fahrenheit = "F"
    case celsius = "C"
}


@Observable
class WeatherViewModel {

    let weatherService: WeatherService = WeatherService()

    var city: String = "Rochester"
    var state: String = "NY"
    var country: String = "US"

    var selectedUnit: TemperatureUnit = .fahrenheit {
        didSet {
            updateTemperatures()
        }
    }

    var icon: String = "cloud.sun.fill"
    var cityName: String = "Rochester" // "-" Blank?
    var description: String = "Sunny"
    var temperature: String = "75ºF"
    var feelsLike: String = "Feels like: 68ºF" // TODO: set the temperature onAppear to the correct Unit (store the unit)
    var humidity: String = "87% humidity"

    var weatherData: WeatherData?

    func fetchWeather() {
        Task {
            do {
                let weatherData = try await weatherService.fetchWeather(city: city, state: state, countryCode: country)
                self.weatherData = weatherData

                if let weather = weatherData.weather.first {
                    icon = sfSymbolName(for: weather.icon)
                    description = weather.description.capitalized
                }

                updateTemperatures()

                humidity = "\(Int(weatherData.main.humidity))% Humidity"
                cityName = weatherData.name

            } catch {
                print("Error: \(error)")
                // TODO: API error or other errors (Show a banner)
            }
        }
    }

    func updateTemperatures() {
        guard var temp = weatherData?.main.temp,
              var feelsLike = weatherData?.main.feelsLike else {
            self.temperature = "-º\(selectedUnit.rawValue)"
            self.feelsLike = "Feels like: -º\(selectedUnit.rawValue)"
            return
        }

        if selectedUnit == .celsius {
            temp = fahrenheitToCelsius(temp)
            feelsLike = fahrenheitToCelsius(feelsLike)
        }
        self.temperature = "\(Int(temp))º\(selectedUnit.rawValue)"
        self.feelsLike = "Feels like: \(Int(feelsLike))º\(selectedUnit.rawValue)"
    }

    func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
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

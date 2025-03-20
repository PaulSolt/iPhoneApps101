//
//  File.swift
//  WeatherApp
//
//  Created by Paul Solt on 3/20/25.
//


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
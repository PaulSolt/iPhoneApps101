//
//  NetworkService.swift
//  WeatherApp-Demo
//
//  Created by Paul Solt on 2/9/25.
//


// Simple API Structure

struct WeatherData: Codable {
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let humidity: Int
    }

    struct Weather: Codable {
        let description: String
        let icon: String
    }

    let name: String
    let main: Main
    let weather: [Weather]
}

// Swift Friendly names

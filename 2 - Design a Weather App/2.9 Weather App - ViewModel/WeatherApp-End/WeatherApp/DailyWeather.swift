//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Paul Solt on 1/16/25.
//

import SwiftUI

// UI Design
// 1. Layout
// 2. Design
// 3. Cleanup

let debugColor = false

struct DailyWeather: View {

    let weatherService: WeatherService = WeatherService()

    @State var city: String = "Rochester"
    @State var state: String = "NY"
    @State var country: String = "US"

    @State var selectedUnit: String = "F"

    @State var icon: String = "cloud.sun.fill" // TODO: Convert from 04d to SF symbols
    @State var cityName: String = "Rochester" // "-" Blank?
    @State var description: String = "Sunny"
    @State var temperature: String = "15.8ºF"
    @State var feelsLike: String = "Feels like: 5.9ºF"
    @State var humidity: String = "87% humidity"

    var body: some View {
        ZStack {
            // Background
//            ContainerRelativeShape() // Rectangle()
//                .foregroundStyle(.blue.gradient)
//                .ignoresSafeArea()

            Image(.blueSky)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .frame(minWidth: 0)

            // Foreground
            VStack(spacing: 0) {
                // Weather Card

                VStack(alignment: .center, spacing: 0) {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit() // Preserve the aspect ratio of the image
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 100, height: 100)

                    Text(cityName)
                        .font(.system(size: 30, weight: .light))

                    Text(temperature)
                        .font(.system(size: 50))

                    Text(description)
                        .font(.system(size: 20))
                        .padding(.bottom, 4)

                    // TODO: Feels like / Humidity
                    Text(feelsLike)
                        .font(.system(size: 14))

                    Text(humidity)
                        .font(.system(size: 14))

                }
                .background(debugColor ? .black : .clear)
                // Force a square layout as big as possible
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .aspectRatio(1, contentMode: .fit)
                
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(.bottom, 40)
                .padding(.top, 20)

                VStack {
                    TextField("City", text: $city)
                    TextField("State (optional)", text: $state)
                    TextField("Country", text: $country)
                }
                .textFieldStyle(.thinMaterial)

                Button {

                    // 1. Make a function call (implement below)
                    // 2. WeatherService.swift
                    // 3. func fetchWeather()
                    // 4. Swift 5 Concurrency (not strict 6)

                    fetchWeather()
                } label: {
                    Text("Refresh")
                }
                .bold()
                .buttonStyle(.borderedProminent)
                .padding(.top, 40)

                Spacer()
            }
            .onChange(of: city) { oldValue, newValue in
                print("City: \(newValue)")
            }
            .overlay(alignment: .bottomTrailing, content: {
                //            Text("Cº") // Option + 0 = º
                HStack {
                    Spacer()
                    Picker("Unit", selection: $selectedUnit) {
                        ForEach(["C", "F"], id: \.self) { unit in
                            Text("º\(unit)")
                                .tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 80)
                }
            })
            .background(debugColor ? .yellow : .clear)
            .padding(.horizontal, 40)

        }
        .colorScheme(.dark)
    }

    func fetchWeather() {
        Task {
            do {
                let weatherData = try await weatherService.fetchWeather(city: city, state: state, countryCode: country)

                if let weather = weatherData.weather.first {
                    icon = weather.icon // TODO: FIXME: Convert to SF Symbol
                    description = weather.description.capitalized
                }
                temperature = "\(weatherData.main.temp)ºF"
                feelsLike = "Feels like: \(weatherData.main.feelsLike)ºF"
                humidity = "\(Int(weatherData.main.humidity))% Humidity"
                cityName = weatherData.name

            } catch {
                print("Error: \(error)")
                // TODO: API error or other errors (Show a banner)
            }
        }
    }
}

#Preview {
    DailyWeather()
}

//
//  ContentView.swift
//  WeatherDemo
//
//  Created by Paul Solt on 12/8/24.
//

import SwiftUI

// MARK: - Weather Data Model
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

// MARK: - Search Modes
enum SearchMode: String, CaseIterable {
    case city = "City, State, Country"
    case coordinates = "Latitude & Longitude"
}

// MARK: - Content View
struct WeatherView: View {
    @State private var searchMode: SearchMode = .city

    @State var viewModel: WeatherViewModel = WeatherViewModel()

    // For City, State, Country Search
    @State private var cityName: String = "Rochester"
    @State private var stateCode: String = "NY"
    @State private var countryCode: String = "US"

    // For Latitude & Longitude Search
    @State private var latitude: String = "43.161"
    @State private var longitude: String = "-77.610"

    // Weather Data
    @State private var weather: WeatherData?
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                // Segmented Control to Switch Modes
                Picker("Search Mode", selection: $searchMode) {
                    ForEach(SearchMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                

                VStack {
                    // Input Fields Based on Selected Mode
                    if searchMode == .city {
                        VStack {
                            TextField("City", text: $cityName)
                                .textFieldStyle(.roundedBorder)
                            
                            TextField("State (optional)", text: $stateCode)
                                .textFieldStyle(.roundedBorder)
                            
                            TextField("Country", text: $countryCode)
                                .textFieldStyle(.roundedBorder)
                        }
                    } else {
                        Form {
                            LabeledContent("Latitude") {
                                TextField("Latitude", text: $latitude)
                                    .textFieldStyle(.roundedBorder)
                            }
                            LabeledContent("Longitude") {
                                TextField("Longitude", text: $longitude)
                                    .textFieldStyle(.roundedBorder)
                            }
                        }
                        .formStyle(.columns) // .grouped, .automatic
                    }
                    TemperatureToggleView(selectedUnit: $viewModel.selectedUnit)
                }
                

                // Search Button
                Button("Fetch Weather") {
                    Task { await fetchWeather() }
                }
                .padding(.bottom)
                .buttonStyle(.borderedProminent)

                // Loading or Error Message
                if isLoading {
                    ProgressView("Fetching Weather...")
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                // Weather Display
                if let weather = weather {
                    VStack(spacing: 8) {
                        Text(weather.name)
                            .font(.largeTitle)
                            .bold()

                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "01d")@2x.png")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 100, height: 100)
                        }

                        let temperature = weather.main.temp.formattedTemperature(unit: viewModel.selectedUnit)
                        let feelsLike = weather.main.feels_like.formattedTemperature(unit: viewModel.selectedUnit)
                        
                        Text("Temperature: \(temperature)")
                            .font(.title3)
                        Text("Feels Like: \(feelsLike)")
                        Text("Humidity: \(weather.main.humidity)%")
                        Text("Condition: \(weather.weather.first?.description.capitalized ?? "N/A")")
                    }
                    .padding()
                }

                Spacer()
            }
            .navigationTitle("Weather App")
            .padding()
        }
    }

    // MARK: - Fetch Weather Data
    func fetchWeather() async {
        isLoading = true
        errorMessage = nil

        let apiKey = "3998a85d6a14e418f519002543a9ccfa" // Replace with your OpenWeatherMap API key
        var urlString: String = ""

        switch searchMode {
        case .city:
            guard let city = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let country = countryCode.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                errorMessage = "Invalid input for city or country."
                isLoading = false
                return
            }
            let state = stateCode.isEmpty ? "" : ",\(stateCode)"
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)\(state),\(country)&units=metric&appid=\(apiKey)"
        case .coordinates:
            guard let lat = Double(latitude), let lon = Double(longitude) else {
                errorMessage = "Invalid latitude or longitude."
                isLoading = false
                return
            }
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)"
        }

        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL."
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedWeather = try JSONDecoder().decode(WeatherData.self, from: data)
            DispatchQueue.main.async {
                self.weather = decodedWeather
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Unable to fetch weather. \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
}

@Observable
class WeatherViewModel {
    var temperatureCelsius: Double = 0.0
    var selectedUnit: TemperatureUnit = .fahrenheit

    var temperature: Double {
        switch selectedUnit {
        case .celsius:
            return temperatureCelsius
        case .fahrenheit:
            return temperatureCelsius * 9 / 5 + 32
        }
    }
    
    var temperatureString: String {
        temperature.formattedTemperature(unit: selectedUnit)
    }
    
    var unitString: String {
        selectedUnit == .celsius ? "C" : "F"
    }
}

extension Double {
    func formattedTemperature(unit: TemperatureUnit) -> String {
        String(format: "%0.1fº\(unit.rawValue)")
    }
}

struct TemperatureToggleView: View {
    @Binding var selectedUnit: TemperatureUnit
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("Unit", selection: $selectedUnit) {
                ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                    Text("º\(unit.rawValue)").tag(unit)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

enum TemperatureUnit: String, CaseIterable {
    case celsius = "C"
    case fahrenheit = "F"
}


//
//  WeatherView.swift
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

struct MaterialTextFieldStyle: TextFieldStyle {
    let material: Material
    
    init(material: Material = .thinMaterial) {
        self.material = material
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(6)
            .background(material)
            .cornerRadius(5)
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(.thinMaterial)
            .cornerRadius(5)
            .clipShape(.capsule)
    }
}

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
        NavigationStack {
            ZStack {
                Image(.blueSky)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, minHeight: 0) // Required to prevent content moving offscreen
                //                    .foregroundStyle(.blue.gradient)
                    .ignoresSafeArea()
                
//                ContainerRelativeShape()
//                    .foregroundStyle(.blue.gradient)
//                    .ignoresSafeArea()
            
                
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
//                                    .textFieldStyle(.roundedBorder)
//                                    .textFieldStyle(MaterialTextFieldStyle(material: .thinMaterial))
                                
                                TextField("State (optional)", text: $stateCode)
//                                    .textFieldStyle(.roundedBorder)
//                                    .textFieldStyle(OvalTextFieldStyle(color: Color(white: 0.3)))
                                
                                TextField("Country", text: $countryCode)
//                                    .textFieldStyle(.roundedBorder)
                            }
                            .textFieldStyle(MaterialTextFieldStyle(material: .thinMaterial))

                        } else {
                            Form {
                                LabeledContent("Latitude") {
                                    TextField("Latitude", text: $latitude)
//                                        .textFieldStyle(.roundedBorder)
                                }
                                LabeledContent("Longitude") {
                                    TextField("Longitude", text: $longitude)
//                                        .textFieldStyle(.roundedBorder)
                                }
                            }
                            .textFieldStyle(MaterialTextFieldStyle())
                            .formStyle(.columns) // .grouped, .automatic
                        }
                        TemperatureToggleView(selectedUnit: $viewModel.selectedUnit)
                    }
                    
                    
                    // Search Button
                    Button("Fetch Weather") {
                        Task { await fetchWeather() }
                    }
                    .bold()
                    .backgroundStyle(.white)
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.blue)
                    .tint(.white)
                    
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
                            
//                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "01d")@2x.png")) { image in
//                                image
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 100, height: 100)
//                            } placeholder: {
//                                ProgressView()
//                                    .frame(width: 100, height: 100)
//                            }
                            
                            let symbol = sfSymbolName(for: weather.weather.first?.icon ?? "")
                            Image(systemName: "cloud.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .symbolRenderingMode(.multicolor)
                                .frame(width: 100, height: 100)
                            
                            Text("\(weather.weather.first?.description.capitalized ?? "N/A")")

                            Text(weather.name)
                                .font(.largeTitle)
                                .bold()

                            
                            let temperature = weather.main.temp.formattedTemperature(unit: viewModel.selectedUnit)
                            let feelsLike = weather.main.feels_like.formattedTemperature(unit: viewModel.selectedUnit)
                            
                            Text("\(temperature)")
                                .font(.largeTitle)
                            Text("Feels Like: \(feelsLike)")
                            Text("\(weather.main.humidity)% humidity")
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .padding(.horizontal, 40)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
//                        .background(
//                            RoundedRectangle(cornerRadius: 16)
////                                .foregroundStyle(.ultraThinMaterial)
//                                .foregroundStyle(.ultraThinMaterial)
//                                .tint(.yellow)
//                        )
                        
                    }
                    
                    Spacer()
                }
                .navigationTitle("Daily Weather")
                .padding()
                
            }
        }
        .preferredColorScheme(.dark)
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
    
    // MARK: - Fetch Weather Data
    func fetchWeather() async {
        isLoading = true
        errorMessage = nil

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
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)\(state),\(country)&units=metric&appid=\(weatherAPIKey)"
        case .coordinates:
            guard let lat = Double(latitude), let lon = Double(longitude) else {
                errorMessage = "Invalid latitude or longitude."
                isLoading = false
                return
            }
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(weatherAPIKey)"
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
                print(decodedWeather)
                self.weather = decodedWeather
//                self.viewModel.temperatureCelsius = self.weather?.main.
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
            return temperatureCelsius * 9.0 / 5 + 32
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
        var temperature: Double = self
        
        if unit == .fahrenheit {
            temperature = temperature * 9.0 / 5 + 32
        }
        return String(format: "%0.1fº\(unit.rawValue)", temperature)
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

#Preview {
    WeatherView()
}

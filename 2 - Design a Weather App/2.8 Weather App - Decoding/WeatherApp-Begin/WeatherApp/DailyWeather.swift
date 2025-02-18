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
                    Image(systemName: "cloud.sun.fill") // "sun.max.fill")
                        .resizable()
                        .scaledToFit() // Preserve the aspect ratio of the image
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 100, height: 100)

                    Text("Rochester")
                        .font(.system(size: 30, weight: .light))

                    Text("73.7ºF")
                        .font(.system(size: 50))

                    Text("Sunny")
                        .font(.system(size: 20))
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
                try await weatherService.fetchWeather(city: city, state: state, countryCode: country)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

#Preview {
    DailyWeather()
}

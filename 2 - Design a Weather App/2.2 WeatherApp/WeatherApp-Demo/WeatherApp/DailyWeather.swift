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

struct DailyWeather: View {

    @State var city: String = "Rochester"
    @State var state: String = "NY"
    @State var country: String = "US"

    @State var selectedUnit: String = "F"

    var body: some View {
        ZStack {
            // Background
            ContainerRelativeShape() // Rectangle()
                .foregroundStyle(.blue)
                .ignoresSafeArea()

            // Foreground

            VStack {
                // WeatherCard
                VStack {
                    Image(systemName: "sun.max.fill") // smoke.fill
                    Text("Rochester")
                    Text("73.7ºF")
                    Text("Sunny")
                }
                // Force a square layout as big as possible
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                // Pad the edges with 40 points
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .padding(40) // Pad the outside edges

                VStack {
                    TextField("City", text: $city)
                    TextField("State (optional)", text: $state)
                    TextField("Country", text: $country)
                }
                .textFieldStyle(.roundedBorder)

                Button {
                    print("Refresh!") // TODO: Make a network request for the weather
                } label: {
                    Text("Refresh")
                }

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
            //        .background(.yellow)
            .padding()
        }
    }
}

#Preview {
    DailyWeather()
}

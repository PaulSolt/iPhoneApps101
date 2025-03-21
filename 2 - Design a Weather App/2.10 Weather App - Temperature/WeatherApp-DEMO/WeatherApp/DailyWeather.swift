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
    @State private var viewModel = WeatherViewModel()

    var body: some View {
        ZStack {
            Image(.blueSky)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .frame(minWidth: 0)

            // Foreground
            VStack(spacing: 0) {
                // Weather Card
                VStack(alignment: .center, spacing: 0) {
                    Image(systemName: viewModel.icon)
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 100, height: 100)

                    Text(viewModel.cityName)
                        .font(.system(size: 30, weight: .light))

                    Text(viewModel.temperature)
                        .font(.system(size: 50))

                    Text(viewModel.description)
                        .font(.system(size: 20))
                        .padding(.bottom, 4)

                    Text(viewModel.feelsLike)
                        .font(.system(size: 14))

                    Text(viewModel.humidity)
                        .font(.system(size: 14))
                }
                .background(debugColor ? .black : .clear)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .aspectRatio(1, contentMode: .fit)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(.bottom, 40)
                .padding(.top, 20)

                VStack {
                    TextField("City", text: $viewModel.city)
                    TextField("State (optional)", text: $viewModel.state)
                    TextField("Country", text: $viewModel.country)
                }
                .textFieldStyle(.thinMaterial)

                Button {
                    viewModel.fetchWeather()
                } label: {
                    Text("Refresh")
                }
                .bold()
                .buttonStyle(.borderedProminent)
                .padding(.top, 40)

                Spacer()
            }
            .onChange(of: viewModel.city) { oldValue, newValue in
                print("City: \(newValue)")
            }
            .overlay(alignment: .bottomTrailing, content: {
                HStack {
                    Spacer()
                    Picker("Unit", selection: $viewModel.selectedUnit) {
                        ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                            Text("º\(unit.symbol)")
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
}

#Preview {
    DailyWeather()
}

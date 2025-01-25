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

    @State var city: String = "Rochester"
    @State var state: String = "NY"
    @State var country: String = "US"

    @State var selectedUnit: String = "F"

    var body: some View {
        ZStack {
            // Background

            ContainerRelativeShape()
                .foregroundStyle(.blue.gradient)
                .ignoresSafeArea()

//            Image(.blueSky)
//                .resizable()
//                .ignoresSafeArea()
//                .scaledToFill() // BUG: Causes layout to stretch offscreen matching width of image (but we want to fill, not fit)
//                .frame(minWidth: 0) // FIX: Fixes the issue (alternate is to use GeometryReader)

            // Foreground

            VStack {
                // WeatherCard
                VStack(alignment: .center, spacing: 0) {
                    Image(systemName: "cloud.sun.fill") //"sun.max.fill") // smoke.fill
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 100, height: 100)

                    Text("Rochester")
                        .font(.system(size: 30, weight: .light))

                    Text("73.7ºF")
                        .font(.system(size: 50, weight: .regular))

                    Text("Sunny")
                        .font(.system(size: 20, weight: .regular))
                }
                .background(debugColor ? .black : .clear) // False Color to see position alignment
                // Force a square layout as big as possible
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Control alignment of text content
                .aspectRatio(1, contentMode: .fit)
                // Pad the edges with 40 points
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .padding(.bottom, 20)
                .background(debugColor ? .yellow : .clear)

                VStack {
                    TextField("City", text: $city)
                    TextField("State (optional)", text: $state)
                    TextField("Country", text: $country)
                }
//                .textFieldStyle(.roundedBorder)
//                .textFieldStyle(MaterialTextFieldStyle(material: .thin)) // Custom style
                .textFieldStyle(.thinMaterial) // Add your own styles

                Button {
                    print("Refresh!") // TODO: Make a network request for the weather
                } label: {
                    Text("Refresh")
                }
                .bold()
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding(.horizontal, 20) // Pad the outside edges
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
        .colorScheme(.dark)
    }
}

#Preview {
    DailyWeather()
}

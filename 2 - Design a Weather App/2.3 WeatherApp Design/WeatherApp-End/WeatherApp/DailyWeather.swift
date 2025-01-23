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
            VStack {
                Image(systemName: "sun.max.fill") // smoke.fill
                Text("Rochester")
                Text("73.7ºF")
                Text("Sunny")
                
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

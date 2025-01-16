//
//  Part1.swift
//  WeatherDemo
//
//  Created by Paul Solt on 1/16/25.
//

import SwiftUI

struct Part1: View {
    @State var selectedUnit: String = "F" //TemperatureUnit = .fahrenheit

    // For City, State, Country Search
    @State private var cityName: String = "Rochester"
    @State private var stateCode: String = "NY"
    @State private var countryCode: String = "US"

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.blue.gradient)
                .ignoresSafeArea()

            //                Image(.blueSky)
            //                    .resizable()
            //                    .scaledToFill()
            //                    .frame(minWidth: 0, minHeight: 0) // Required to prevent content moving offscreen
            //                    .ignoresSafeArea()

            VStack {
                VStack(spacing: 0) {
                    Image(systemName: "cloud.sun.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 100, height: 100)

                    Text("Rochester")
                        .font(.system(size: 30, weight: .light))

                    Text("73.7ºF")
                        .font(.system(size: 50, weight: .regular))

                    Text("Sunny")
                        .font(.system(size: 20, weight: .regular))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
                .padding(.bottom, 40)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .padding(.top, 20)

                VStack {
                    TextField("City", text: $cityName)
//                        .textFieldStyle(.roundedBorder)
//                        .textFieldStyle(MaterialTextFieldStyle(material: .thinMaterial))

                    TextField("State (optional)", text: $stateCode)

                    TextField("Country", text: $countryCode)
                }
                .textFieldStyle(MaterialTextFieldStyle(material: .thinMaterial))
                .padding(.top)

                // Search Button
                Button("Refresh") {
                    print("Refresh")
                }
                .bold()
                .backgroundStyle(.white)
                .padding()
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.blue)
                .tint(.white)

                Spacer()
            }
            .padding(.horizontal, 40)
        }
        .overlay {
            VStack {
                Spacer()
                HStack {
                    Picker("Unit", selection: $selectedUnit) {
                        ForEach(["C", "F"], id: \.self) { unit in
                            Text("º\(unit)").tag(unit)
                        }
                    }
                    .frame(width: 70)
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.bottom, 20)
                .padding(.trailing, 40) //[.trailing, .bottom], 20)
            }
        }
        .preferredColorScheme(.dark)
    }
}

enum TemperatureUnit: String, CaseIterable {
    case celsius = "C"
    case fahrenheit = "F"
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
            .frame(width: 70)
            .pickerStyle(SegmentedPickerStyle())
        }
    }
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

#Preview {
   Part1()
}

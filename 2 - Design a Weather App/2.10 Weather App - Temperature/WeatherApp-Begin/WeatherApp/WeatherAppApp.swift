//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Paul Solt on 1/16/25.
//

import SwiftUI

@main
struct WeatherAppApp: App {

    @State var viewModel: WeatherViewModel = WeatherViewModel()

    var body: some Scene {
        WindowGroup {
            DailyWeather(viewModel: viewModel)
        }
    }
}

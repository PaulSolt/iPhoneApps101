//
//  CounterViewModel.swift
//  SwiftUI Symbols
//
//  Created by Paul Solt on 12/28/24.
//


import SwiftUI
import Combine

class CounterViewModel: ObservableObject {
    @Published var count = 0
    @Published var isOn = false
}

struct PublishedExampleView: View {
    @StateObject private var viewModel = CounterViewModel()
    
    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            Button("Increment") {
                viewModel.count += 1
            }
            Toggle("Is On?", isOn: $viewModel.isOn)

        }
        .background(viewModel.isOn ? .blue : .red)
        .padding()
    }
}

#Preview {
    PublishedExampleView()
}

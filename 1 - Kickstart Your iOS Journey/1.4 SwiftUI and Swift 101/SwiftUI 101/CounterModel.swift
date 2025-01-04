//
//  CounterModel.swift
//  SwiftUI 101
//
//  Created by Paul Solt on 12/26/24.
//


import SwiftUI
import Observation

@Observable 
class CounterModel {
    var value: Int = 0
    var doubled: Int { value * 2 }
}

struct PropertiesView: View {
    @State private var counter = CounterModel()
    
    var body: some View {
        VStack {
            Text("Value: \(counter.value)")
            Text("Doubled: \(counter.doubled)")
            Button("Increment") {
                counter.value += 1
            }
        }
        .padding()
        .onChange(of: counter.value) { oldValue, newValue in
            print("Changed from \(oldValue) to \(newValue)")
        }
    }
}

#Preview("Properties with @Observable") {
    PropertiesView()
}

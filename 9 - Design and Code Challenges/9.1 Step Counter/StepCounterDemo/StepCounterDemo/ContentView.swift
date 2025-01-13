//
//  ContentView.swift
//  StepCounterDemo
//
//  Created by Paul Solt on 1/11/25.
//

import SwiftUI

// 1. Layout
// 2. Design
// 3. Cleanup

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

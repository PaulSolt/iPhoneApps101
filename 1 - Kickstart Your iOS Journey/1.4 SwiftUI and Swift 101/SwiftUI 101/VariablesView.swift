//
//  VariablesView.swift
//  SwiftUI 101
//
//  Created by Paul Solt on 12/26/24.
//


import SwiftUI

struct VariablesView: View {
    var greeting: String = "Hello" // Can change later
    var constantValue: Int = 42 // Constant

    init() {
        // Called on start
        print("App started!")
        greeting = "Goodbye"
        constantValue = 100
    }

    var body: some View {
        Text("\(greeting), Swift! The number is: \(constantValue)")
            .font(.largeTitle)
            .padding()
            .background(.yellow)
    }
}

#Preview("Variables") {
    VariablesView()
}

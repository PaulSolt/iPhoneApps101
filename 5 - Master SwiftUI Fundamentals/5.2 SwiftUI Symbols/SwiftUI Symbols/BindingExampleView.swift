//
//  BindingExampleView.swift
//  SwiftUI Symbols
//
//  Created by Paul Solt on 12/28/24.
//


import SwiftUI

struct BindingExampleView: View {
    @State private var isToggled = false
    
    var body: some View {
        VStack {
            Toggle("Enable Feature", isOn: $isToggled) // Binding with $
            Text(isToggled ? "Feature is ON" : "Feature is OFF")
        }
        .padding()
    }
}

#Preview {
    BindingExampleView()
}

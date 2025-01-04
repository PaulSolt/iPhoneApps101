//
//  ContentView.swift
//  MyFirstApp
//
//  Created by Paul Solt on 12/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "cloud.sun.fill")
                .symbolRenderingMode(.multicolor)
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Paul!")
//                .bold()
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue.gradient)
    }
}

#Preview {
    ContentView()
}

//
//  DataTypesView.swift
//  SwiftUI 101
//
//  Created by Paul Solt on 12/26/24.
//


import SwiftUI

struct DataTypesView: View {
    var name: String = "Paul Solt"
    var age: Int = 38
    var piValue: Double = .pi
    var likesSwiftUI: Bool = false

    var body: some View {
        VStack {
            Text("Name: \(name)")
            Text("Age: \(age)")
            Text("Pi: \(piValue)")
            Text("Likes SwiftUI: \(likesSwiftUI)")
        }
        .font(.largeTitle)
        .background(likesSwiftUI ? .green : .red)
        .padding()
    }
}

#Preview("Data Types") {
    DataTypesView()
}

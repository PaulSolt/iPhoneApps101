//
//  ArraysView.swift
//  SwiftUI 101
//
//  Created by Paul Solt on 12/26/24.
//


import SwiftUI

struct ArraysView: View {
    let fruits = ["Apple", "Banana", "Cherry", "Orange"]
    let symbols = ["applelogo", "figure.run", "person.crop.square.on.square.angled", "sun.max.fill"]

    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(symbols, id: \.self) { symbol in
                    Image(systemName: symbol)
                }
            }

            List(0..<fruits.count, id: \.self) { index in
                HStack {
                    Image(systemName: symbols[index])
                    Text(fruits[index])
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview("Arrays with SF Symbols") {
    ArraysView()
}

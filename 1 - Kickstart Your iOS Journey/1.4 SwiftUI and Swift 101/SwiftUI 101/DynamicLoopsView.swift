//
//  DynamicLoopsView.swift
//  SwiftUI 101
//
//  Created by Paul Solt on 12/26/24.
//


import SwiftUI

struct DynamicLoopsView: View {
    @State private var items = [1, 2, 3]
    @State private var nextValue = 4

    var body: some View {
        VStack {
            List(items, id: \.self) { item in
                Text("Item: \(item)")
                    .font(.largeTitle)
            }
            
            Button("Add Item") {
                items.append(nextValue)
                nextValue += 1
            }
        }
        .listStyle(.plain)
        .padding()
    }
}

#Preview("Loops (II) - Dynamic") {
    DynamicLoopsView()
}

//
//  DictionariesView.swift
//  SwiftUI 101
//
//  Created by Paul Solt on 12/26/24.
//


import SwiftUI

struct DictionariesView: View {
    let animals = [
        "Dog": "🐶",
        "Cat": "🐱",
        "Mouse": "🐭"
    ]
    
    var body: some View {
        List(Array(animals.keys), id: \.self) { key in
            if let emoji = animals[key] {
                Text("\(key): \(emoji)")
            }
        }
    }
}

#Preview("Dictionaries with Emojis") {
    DictionariesView()
}

//
//  LoopsView.swift
//  SwiftUI 101
//
//  Created by Paul Solt on 12/26/24.
//


import SwiftUI

struct LoopsView: View {
    let numbers = [1, 2, 3, 4, 5]

    init() {
        for number in numbers { // Swift
            print("number: \(number)")
        }
    }

    var body: some View {
        VStack {
            ForEach(numbers, id: \.self) { num in // SwiftUI
                Text("Number: \(num)")
            }
        }
        .padding()
    }
}

#Preview("Loops (I)") {
    LoopsView()
}

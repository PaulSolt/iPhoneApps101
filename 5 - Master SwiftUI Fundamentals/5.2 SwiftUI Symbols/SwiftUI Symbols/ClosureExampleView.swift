//
//  ClosureExampleView.swift
//  SwiftUI Symbols
//
//  Created by Paul Solt on 12/28/24.
//


import SwiftUI

struct ClosureExampleView: View {
    let numbers = [1, 2, 3]
    let doubledNumbers: [Int]

    init() {
        doubledNumbers = numbers.map { number in
            number * 2
        }
    }
    var body: some View {
        VStack {
//            ForEach(numbers.map { $0 * 2 }, id: \.self) { number in
            ForEach(doubledNumbers, id: \.self) { number in
                Text("Double: \(number)")
            }
        }
    }
}

#Preview {
    ClosureExampleView()
}

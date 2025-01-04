//
//  Fruit.swift
//  SwiftUI 101
//
//  Created by Paul Solt on 12/26/24.
//


import SwiftUI

enum Fruit {
    case apple
    case orange
    case banana
}

struct SwitchStatementsView: View {
    var fruit: Fruit = .apple

    init() {
        fruit = .orange
    }

    var body: some View {
        VStack {
            switch fruit {
            case .apple:
                Text("An Apple")
            case .orange:
                Text("An Orange")
            case .banana:
                Text("A Banana")
            }
        }
        .font(.system(size: 79))
        .padding()
    }
}

#Preview("Switch Statements") {
    SwitchStatementsView()
}

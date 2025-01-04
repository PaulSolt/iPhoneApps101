//
//  IfStatementsView.swift
//  SwiftUI 101
//
//  Created by Paul Solt on 12/26/24.
//


import SwiftUI

struct IfStatementsView: View {
    @State var userAge: Int = 7
    @State var userAgeString = "7"

    var body: some View {
        VStack {
            TextField("Age", text: $userAgeString)
                .textFieldStyle(.roundedBorder)
                .onChange(of: userAgeString) { oldValue, newValue in
                    if let userAge = Int(userAgeString) {
                        self.userAge = userAge
                    }
                }
            Text("Age: \(userAge)")
//            if userAge >= 18 { // SwiftUI if/else: Can break animations
//                Text("Adult")
//            } else {
//                Text("Minor")
//            }
            Text(userAge >= 18 ? "Adult" : "Minor")
                .background(userAge < 18 ? .red : .clear) // Ternary
        }
        .font(.largeTitle)
        .padding()
    }
}

#Preview("If Statements") {
    IfStatementsView()
}

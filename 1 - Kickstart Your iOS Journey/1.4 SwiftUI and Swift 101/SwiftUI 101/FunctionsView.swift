//
//  FunctionsView.swift
//  SwiftUI 101
//
//  Created by Paul Solt on 12/26/24.
//


import SwiftUI

func greetUser(name: String) -> String {
    print("Saying hello")
    return "Hello, \(name)!"
}

func onboardingMessage(userName: String = "Friend") -> String {
    return "Hello, \(userName)! Welcome onboard."
}

struct FunctionsView: View {
    var userName: String = "@PaulSolt"

    var body: some View {
        Text(greetUser(name: userName)) // Text("Hello, \(userName)!")
            .foregroundStyle(.blue)
            .font(.system(size: 70, weight: .bold))
            .padding()
        Text(onboardingMessage(userName: "Steph"))
            .bold()
            .monospaced()
    }
}

#Preview("Functions (I)") {
    FunctionsView()
}

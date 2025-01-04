//
//  OptionalsView.swift
//  SwiftUI 101
//
//  Created by Paul Solt on 12/26/24.
//


import SwiftUI

func optionalWelcome(name: String?) -> String {
    guard let name, !name.isEmpty else {
        return "Hello, Stranger!"
    }
    return "Hello, \(name)!"
}

struct OptionalsView: View {
    let userName: String? = "Steph" // "Paul" // nil

    var body: some View {
        Text(optionalWelcome(name: userName))
            .padding()
    }
}

#Preview("Optionals") {
    OptionalsView()
}

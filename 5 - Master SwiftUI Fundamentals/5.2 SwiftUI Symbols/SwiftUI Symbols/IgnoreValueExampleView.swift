//
//  IgnoreValueExampleView.swift
//  SwiftUI Symbols
//
//  Created by Paul Solt on 12/28/24.
//


import SwiftUI

struct IgnoreValueExampleView: View {

    var body: some View {
        VStack {
            let (_, second) = (1, "Second Value")
            Text("Ignored First Value, Kept: \(second)")
        }
    }
}

#Preview {
    IgnoreValueExampleView()
}

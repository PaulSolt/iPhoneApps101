//
//  OmitParameterExampleView.swift
//  SwiftUI Symbols
//
//  Created by Paul Solt on 12/28/24.
//


import SwiftUI

func greet(_ name: String) -> String {
//func greet(name: String) -> String {
    return "Hello, \(name)!"
}

struct OmitParameterExampleView: View {
    var body: some View {
        Text(greet("Swift Developer"))
//        Text(greet(name: "Swift Developer"))
    }
}

#Preview {
    OmitParameterExampleView()
}

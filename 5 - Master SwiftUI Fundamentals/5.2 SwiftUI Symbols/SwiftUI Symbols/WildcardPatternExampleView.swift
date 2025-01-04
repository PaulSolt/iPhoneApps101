//
//  WildcardPatternExampleView.swift
//  SwiftUI Symbols
//
//  Created by Paul Solt on 12/28/24.
//


import SwiftUI

struct WildcardPatternExampleView: View {
    let number = 8

    var body: some View {
        VStack {
            switch number {
            case 1: Text("One")
//            case _: Text("Not One") // Matches everything else
            default:
                Text("Not One")
            }
        }
    }
}

#Preview {
    WildcardPatternExampleView()
}

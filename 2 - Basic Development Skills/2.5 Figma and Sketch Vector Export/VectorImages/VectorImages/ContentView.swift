//
//  ContentView.swift
//  VectorImages
//
//  Created by Paul Solt on 12/19/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(.thumbsUpPdf)
                .resizable()
                .scaledToFit()

            //                .scaleEffect(3)

//            Image(.thumbsUpSvg)
//                .resizable()
//                .scaledToFit()

            Image(.bike)
                .resizable()
                .scaledToFit()
                .frame(width: 150)

            Image(.heart)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 24)
                .foregroundStyle(.pink)

            Button {
                print("pressed!")
            } label: {
                Image(.electric)
            }

        }
        .padding(.horizontal, 50)
        .background(.black)
//        .padding()
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  BasicSwiftUI
//
//  Created by Paul Solt on 12/16/24.
//

import SwiftUI

let debug = false

struct ContentView: View {
    let padding: CGFloat = 50
    
    @State var spacing: Double = 20
    @State var items: Int = 5
    
    var body: some View {
        ZStack {
            // Background
//            Image(.greece201429)
//                .resizable()
////                .scaledToFit()
//                .scaledToFill() // FIXME: Geometry or readSize() modifier

//            Rectangle()
//                .foregroundStyle(.blue.gradient)
//                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: spacing) {
                Button("Buy Now") {
                    print("Buy it now")
                }
                .bold()
                .buttonStyle(.borderedProminent)
                
                Button {
                    print("BUY")
                } label: {
                    Label("BUY NOW", systemImage: "cart.fill")
                        .labelStyle(.titleAndIcon)
                        .bold()
                }
                .buttonStyle(.borderedProminent)

//                Image("FlatButton") // Old way!
//                Image(.flatButton) // New way with Asset Catalog

                Button {
                    print("Pressed flat button")
                } label: {
                    ZStack {
//                        Image(.flatButton) // Background
                        Image(.gradientButton34) // .gradientButton) // Background

                        Text("Press Me") // Foreground
                            .foregroundStyle(.white)
                            .bold()
                    }
                }
                .frame(maxWidth: 200, maxHeight: 34)




                Spacer()
                
                Image(systemName: "cloud.sun.fill") //"sun.max.fill")
                    .resizable()
                    .symbolRenderingMode(.multicolor)
                    .scaledToFit()
                    .frame(width: 120, height: 120)
//                    .imageScale(.large)
//                    .foregroundStyle(.tint)
                Text("Hello, world!")
                    .font(.largeTitle)
                    .multilineTextAlignment(.trailing)
                Text("Subtitle: The world of code")
                
                HStack {
                    //                Spacer()
                    Text("#hashtag")
                    Text("#dogs")
                    Text("#beach2024")
                    Spacer()
                }
                .foregroundStyle(.secondary) // .primary
//                .background(.red)
                
                Slider(value: $spacing, in: 0...50)
                    .onChange(of: spacing) { oldValue, newValue in
                        print(newValue)
                    }
                Stepper("Number of items: \(items)", value: $items, in: 1...10)
                
//                ForEach(1...items, id: \.self) { index in
//                    Text("Item: \(index)")
//                }
                //            Spacer()
            }
            //        .padding(.horizontal, padding)
            .background(debug ? .yellow : .clear)
        }
        .padding()
        .colorScheme(.dark) // Force a dark layout only
        .background {
            ZStack {
                Image(.greece201429)
                    .resizable()
//                    .scaledToFit()
                    .scaledToFill()
                Rectangle()
                    .foregroundStyle(.black.opacity(0.5))
            }
            .ignoresSafeArea()

        }
    }
}

#Preview {
    ContentView()
}

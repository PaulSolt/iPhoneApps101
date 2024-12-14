//
//  ContentView.swift
//  FixedSizeDemo
//
//  Created by Paul Solt on 12/9/24.
//

import SwiftUI

struct FixedSizeDemo: View {
    @State private var useFixedSizeVertical = false
    @State private var useFixedSizeHorizontal = false
    @State private var maxWidth: CGFloat = 200
    @State private var parentHeight: CGFloat = 100

    func useFixedSize() -> Bool {
        return useFixedSizeVertical || useFixedSizeHorizontal
    }
    
    func textForSize() -> String {
        if useFixedSizeVertical && useFixedSizeHorizontal {
          return "You should use one or the other, it will prefer horizontal growth over vertical"
        } else if useFixedSizeHorizontal {
            return "With .fixedSize(horizontal) The text width grows to fit the wrapped content. It may grow out of bounds."
        } else if useFixedSizeVertical {
            return "With .fixedSize(vertical) The text height grows to fit the wrapped content. It may grow out of bounds if height restricted."
        } else {
            return "Default: Without .fixedSize, the parent constraints control the size. The text may clip if height is limited."
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text(textForSize() )
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()

            HStack {
                if useFixedSize() {
                    Text("This is a long piece of text that should wrap when constrained by the parent. Observe how the height adjusts to fit.")
                        .fixedSize(horizontal: useFixedSizeHorizontal, vertical: useFixedSizeVertical)
                        .frame(maxWidth: maxWidth)
                        .border(Color.blue)
                } else {
                    Text("This is a long piece of text that should wrap when constrained by the parent. Observe how the height adjusts to fit.")
                        .frame(maxWidth: maxWidth)
                        .border(Color.red)
                }
            }
            .frame(height: parentHeight)
            .border(Color.green)

            VStack(spacing: 10) {
                HStack {
                    Text("Max Width: \(Int(maxWidth))")
                    Slider(value: $maxWidth, in: 100...400, step: 10)
                }

                HStack {
                    Text("Parent Height: \(Int(parentHeight))")
                    Slider(value: $parentHeight, in: 50...200, step: 10)
                }
            }
            .padding()

            Toggle(isOn: $useFixedSizeHorizontal) {
                Text(".fixedSize(horizontal)")
            }
            Toggle(isOn: $useFixedSizeVertical) {
                Text(".fixedSize(vertical)")
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    FixedSizeDemo()
}

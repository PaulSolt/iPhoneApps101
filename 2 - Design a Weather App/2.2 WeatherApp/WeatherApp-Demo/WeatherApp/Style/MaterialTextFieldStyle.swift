//
//  MaterialTextFieldStyle.swift
//  WeatherApp-Demo
//
//  Created by Paul Solt on 1/23/25.
//

import SwiftUI

public struct MaterialTextFieldStyle: TextFieldStyle {
    let material: Material

    init(material: Material = .thinMaterial) {
        self.material = material
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(6)
            .background(material)
            .cornerRadius(5)
    }
}

// You can add styles to auto-complete by Conditionally Conforming to a Protocol
extension TextFieldStyle where Self == MaterialTextFieldStyle {
//    extension TextFieldStyle where Self == MaterialTextFieldStyle {

    /// A text field style with a system-defined rounded border with a thin material.
    public static var thinMaterial: MaterialTextFieldStyle {
        MaterialTextFieldStyle(material: .thin)
    }
}

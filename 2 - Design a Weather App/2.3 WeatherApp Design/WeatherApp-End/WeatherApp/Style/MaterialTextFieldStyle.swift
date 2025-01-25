//
//  MaterialTextFieldStyle.swift
//  WeatherApp
//
//  Created by Paul Solt on 1/24/25.
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

extension TextFieldStyle where Self == MaterialTextFieldStyle {
    public static var thinMaterial: MaterialTextFieldStyle {
        MaterialTextFieldStyle(material: .thin)
    }
}

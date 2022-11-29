//
//  EmailTextFieldModifiers.swift
//  CryptoApp
//
//  Created by NikoS on 29.11.2022.
//

import SwiftUI

struct TextFieldModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(50)
    }
}

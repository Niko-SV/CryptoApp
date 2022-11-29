//
//  AuthTextView.swift
//  CryptoApp
//
//  Created by NikoS on 29.11.2022.
//

import SwiftUI

struct AuthTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .font(.caption)
            .foregroundColor(.red)
    }
}

struct AuthTextView_Previews: PreviewProvider {
    static var previews: some View {
        AuthTextView(text: "Example")
    }
}

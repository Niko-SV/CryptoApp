//
//  SignInUpText.swift
//  CryptoApp
//
//  Created by NikoS on 29.11.2022.
//

import SwiftUI

struct SignInUpText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(Color.white)
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(50)
    }
}

struct SignInUpText_Previews: PreviewProvider {
    static var previews: some View {
        SignInUpText(text: "Example")
    }
}

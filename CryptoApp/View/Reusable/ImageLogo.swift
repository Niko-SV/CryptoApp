//
//  ImageLogo.swift
//  CryptoApp
//
//  Created by NikoS on 29.11.2022.
//

import SwiftUI

struct ImageLogo: View {
    var body: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
    }
}

struct ImageLogo_Previews: PreviewProvider {
    static var previews: some View {
        ImageLogo()
    }
}

//
//  InternetConnectionIsNotAvailable.swift
//  CryptoApp (iOS)
//
//  Created by NikoS on 19.07.2022.
//

import SwiftUI

struct InternetConnectionIsNotAvailable: View {
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        if !Reachability.isConnectedToNetwork() {
            HStack {
                Text("No Internet connection. Last update was \(CurrentDateChecker().getData())")
                    .font(.caption2)
                    .padding()
            }
            .background(Color.red)
            .cornerRadius(10)
            .padding()
        }
    }
    
}

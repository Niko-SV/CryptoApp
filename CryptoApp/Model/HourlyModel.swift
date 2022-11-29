//
//  HourlyModel.swift
//  CryptoApp
//
//  Created by NikoS on 14.02.2022.
//

import SwiftUI

struct HourlyModel: Identifiable {
    
    var id = UUID()
    var price: String
    var value: String
    var dynamicSymbol: String
    var color: Color
    
}

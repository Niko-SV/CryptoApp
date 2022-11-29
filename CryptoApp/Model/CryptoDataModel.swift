//
//  CryptoDataModel.swift
//  CryptoApp
//
//  Created by NikoS on 11.02.2022.
//

import Foundation

struct CryptoData: Decodable {
    let coins: [Coin]
}

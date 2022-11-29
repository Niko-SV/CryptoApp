//
//  CryptoDataContainer.swift
//  CryptoApp
//
//  Created by NikoS on 11.02.2022.
//

import Foundation

struct CryptoDataContainer: Decodable {
    let status: String
    let data: CryptoData
}

//
//  CoinModel.swift
//  CryptoApp
//
//  Created by NikoS on 09.02.2022.
//

import Foundation

struct Coin: Decodable, Hashable {
    var uuid: String
    var name: String
    var price: String
    var iconUrl: String
    var sparkline: [String]
    
    private enum CodingKeys: String, CodingKey {
        case uuid, name, price, iconUrl, sparkline
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try container.decode(String.self, forKey: .uuid)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(String.self, forKey: .price)
        iconUrl = try container.decode(String.self, forKey: .iconUrl)
        iconUrl = iconUrl.replacingOccurrences(of: "svg", with: "png")
        sparkline = try container.decode([String].self, forKey: .sparkline)
    }
}

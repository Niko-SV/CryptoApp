//
//  CoinViewModel.swift
//  CryptoApp
//
//  Created by NikoS on 09.02.2022.
//

import SwiftUI
import Kingfisher

final class CoinDetailsViewModel {
    
    private static let chevronUpDown = "arrow.up.arrow.down"
    private static let chevronUp = "arrow.up"
    private static let chevronDown = "arrow.down"
    
    @Published var hourlyArray = [HourlyModel]()
    
    private let coin: CoinObject
    
    init(_ coin: CoinObject) {
        self.coin = coin
        self.fillHourlyModel()
    }
    
    func fillHourlyModel() {
        let hourly = CurrentDateChecker().getHourlyArray()
        let hourPrice = getHourPrice()
        
        for i in 0..<hourPrice.count {
            let dynamicSymbol: String
            let color: Color
            if (i < hourPrice.count - 1 && hourPrice[i] == hourPrice[i + 1])
                || (i > 0 && i == hourPrice.count - 1) {
                dynamicSymbol = CoinDetailsViewModel.chevronUpDown
                color = Color.yellow
            } else if hourPrice[i] > hourPrice[i + 1] {
                dynamicSymbol = CoinDetailsViewModel.chevronUp
                color = Color.green
            } else {
                dynamicSymbol = CoinDetailsViewModel.chevronDown
                color = Color.red
            }
            hourlyArray.append(HourlyModel(id: UUID(), price: hourPrice[i], value: hourly[i], dynamicSymbol: dynamicSymbol, color: color))
        }
    }
    
    func getHourPrice() -> [String] {
        let maxSparklineIndex = coin.sparkline.count - 1
        let maxIndex =  maxSparklineIndex > Constants.dateIndex ? Constants.dateIndex : maxSparklineIndex
        return coin.sparkline[0...maxIndex].map { value in CoinDetailsViewModel.format(nonFormattedPrice: value)}.reversed()
    }

    var name: String {
        return coin.name ?? ""
    }
    
    var formattedPrice: String {
        return CoinDetailsViewModel.format(nonFormattedPrice: coin.price ?? "")
    }
    
    static func format(nonFormattedPrice: String) -> String {
        let priceFormatter = NumberFormatter()
        
        priceFormatter.locale = Locale(identifier: "en_US")
        priceFormatter.numberStyle = .currency
        priceFormatter.currencySymbol = "$ "
        
        guard let price = Double(nonFormattedPrice), let formattedPrice = priceFormatter.string(from: NSNumber(value: price)) else { return "" }
        
        return formattedPrice
    }
    
    var displayText: String {
        return name + " - " + formattedPrice
    }
    
}

extension CoinDetailsViewModel: Hashable {
    static func == (lhs: CoinDetailsViewModel, rhs: CoinDetailsViewModel) -> Bool {
        return lhs.formattedPrice == lhs.formattedPrice && lhs.name == rhs.name && lhs.displayText == rhs.displayText
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(formattedPrice)
        hasher.combine(name)
        hasher.combine(displayText)
    }
}

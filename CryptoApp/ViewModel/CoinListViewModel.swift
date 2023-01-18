//
//  CoinListViewModel.swift
//  CryptoApp
//
//  Created by NikoS on 09.02.2022.
//

import Foundation
import Combine

final class CoinsFetch: ObservableObject {
    
    private let networkService = NetworkService()
    
    @Published var coins = [Coin]()
    
    var cancellable: AnyCancellable?
    
    func fetchCoins() {
        cancellable = networkService.fetchCoins()
            .sink(receiveCompletion: { _ in
        }, receiveValue: { cryptoContainer in
            self.coins = cryptoContainer.data.coins
        })
    }
    
    func addToFavorites(coin: CoinObject) {
        
    }
}

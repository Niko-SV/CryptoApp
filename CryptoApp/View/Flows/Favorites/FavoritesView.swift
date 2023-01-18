//
//  FavoritesView.swift
//  CryptoApp
//
//  Created by NikoS on 02.06.2022.
//

import SwiftUI
import Reteno

struct FavoritesView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var coinResults: FetchedResults<CoinObject>
    var coins: [CoinObject] { Array(coinResults) }
    
    var body: some View {
        List(coins, id: \.uuid) { coin in
            if coin.isFavorite == true {
                CoinListItemView(url: coin.iconUrl ?? "", text: coin.name ?? "", navigationView: CoinDetailsView(coinDetailsViewModel: CoinDetailsViewModel(coin)))
                    .contextMenu {
                        Button {
                            coin.isFavorite = false
                            Reteno.logEvent(eventTypeKey: "Coin was deleted from favorites", parameters: [Event.Parameter(name: "CoinName", value: "\(String(describing: coin.name))")])
                        } label: {
                            Text("Delete from favorites")
                            Image(systemName: "trash")
                        }
                    }
            }
        }
        .listStyle(.plain)
        
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

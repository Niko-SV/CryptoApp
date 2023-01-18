//
//  ContentView.swift
//  CryptoApp
//
//  Created by NikoS on 09.02.2022.
//

import SwiftUI
import Reteno

struct CoinListView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var coinResults: FetchedResults<CoinObject>
    var coins: [CoinObject] { Array(coinResults) }
    
    var body: some View {
        List(coins, id: \.uuid) { coin in
            CoinListItemView(url: coin.iconUrl ?? "", text: coin.name ?? "", navigationView: CoinDetailsView(coinDetailsViewModel: CoinDetailsViewModel(coin)))
                .contextMenu {
                    Button {
                        coin.isFavorite = true
                        Reteno.logEvent(eventTypeKey: "Coin was added to favorites", parameters: [Event.Parameter(name: "CoinName", value: "\(String(describing: coin.name))")])
                    } label: {
                        Text("Add to favorites")
                        Image(systemName: "star")
                    }
                }
        }
        .listStyle(.plain)
        
    }
}

struct CoinList_Previews: PreviewProvider {
    static var previews: some View {
        CoinListView()
    }
}

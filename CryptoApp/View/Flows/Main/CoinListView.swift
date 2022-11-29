//
//  ContentView.swift
//  CryptoApp
//
//  Created by NikoS on 09.02.2022.
//

import SwiftUI

struct CoinListView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var isLongPressed = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var coinResults: FetchedResults<CoinObject>
    var coins: [CoinObject] { Array(coinResults) }
    
    var body: some View {
        List(coins, id: \.uuid) { coin in
            CoinListItemView(url: coin.iconUrl ?? "", text: coin.name ?? "", navigationView: CoinDetailsView(coinDetailsViewModel: CoinDetailsViewModel(coin)))
        }
        .listStyle(.plain)
    }
}

struct CoinList_Previews: PreviewProvider {
    static var previews: some View {
        CoinListView()
    }
}

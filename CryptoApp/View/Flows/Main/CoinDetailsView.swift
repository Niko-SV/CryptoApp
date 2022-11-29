//
//  CoinDetails.swift
//  CryptoApp
//
//  Created by NikoS on 09.02.2022.
//

import SwiftUI

struct CoinDetailsView: View {

    private var coinDetailsViewModel: CoinDetailsViewModel
    
    init(coinDetailsViewModel: CoinDetailsViewModel) {
        self.coinDetailsViewModel = coinDetailsViewModel
    }
    
    var body: some View {
        List {
            ForEach(coinDetailsViewModel.hourlyArray) { hourlyModel in
                CoinDetailsItemView(hourlyModel: hourlyModel)
            }
        }
        .navigationBarTitle("24h dynamic")
    }
}

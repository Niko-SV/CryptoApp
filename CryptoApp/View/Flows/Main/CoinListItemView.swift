//
//  CoinListItemView.swift
//  CryptoApp
//
//  Created by NikoS on 24.10.2022.
//

import SwiftUI
import Kingfisher

struct CoinListItemView: View {
    var url: String
    var text: String
    var navigationView: CoinDetailsView
    @State private var reload = false
    
    var body: some View {
        HStack {
            KFImage(URL(string: url))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:50, height:50)
                .onAppear {
                    reload.toggle()
                }
            Text(text)
                .layoutPriority(100)
            NavigationLink(destination: navigationView) {
            }
        }
    }
}

struct CoinListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CoinListItemView(url: "", text: "", navigationView: CoinDetailsView(coinDetailsViewModel: CoinDetailsViewModel(CoinObject())))
    }
}

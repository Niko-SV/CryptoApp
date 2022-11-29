//
//  CoinDetailsItemViewModel.swift
//  CryptoApp
//
//  Created by NikoS on 14.02.2022.
//

import SwiftUI

struct CoinDetailsItemView: View {
    var hourlyModel: HourlyModel
    
    var body: some View {
        Section(header: Text(hourlyModel.value)) {
            HStack {
                Text(hourlyModel.price)
                Spacer()
                Image(systemName: hourlyModel.dynamicSymbol)
                    .foregroundColor(hourlyModel.color)
            }
            .headerProminence(.increased)
        }
    }
}

struct CoinDetailsItemViewModel_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailsItemView(hourlyModel: HourlyModel(id: UUID(), price: "123", value: "123", dynamicSymbol: "chevron.up", color: Color.red))
    }
}

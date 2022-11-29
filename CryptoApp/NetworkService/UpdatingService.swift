//
//  UpdatingService.swift
//  CryptoApp
//
//  Created by NikoS on 26.09.2022.
//

import SwiftUI
import Combine
import CoreData

class UpdatingService {
    static let shared: UpdatingService = UpdatingService()
    var cancellable: AnyCancellable?
    var context = CoreDataStack.instance.backgroundContext
    
    func deleteCoins() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CoinObject")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.context.execute(deleteRequest)
        } catch {
            print(error)
        }
    }
    
    func fetchCoins() {
        cancellable = NetworkService.shared.fetchCoins()
            .sink { completion in
            } receiveValue: { cryptoContainer in
                do {
                    cryptoContainer.data.coins.forEach {
                        let object = CoinObject(context: self.context, uuid: $0.uuid, name: $0.name, price: $0.price, iconUrl: $0.iconUrl, sparklineRaw: "")
                        object?.sparkline = $0.sparkline
                    }
                    try self.context.save()
                } catch {
                    print (error)
                }
            }
    }
}

//
//  CoinEntity+CoreDataClass.swift
//  
//
//  Created by NikoS on 26.09.2022.
//
//

import Foundation
import CoreData

@objc(CoinObject)
public class CoinObject: NSManagedObject{
    private let sparklineSeparator = "|"

    convenience init?(context: NSManagedObjectContext, uuid: String, name: String, price: String, iconUrl: String, sparklineRaw: String, isFavorite: Bool) {
        guard let brandsEntity = NSEntityDescription.entity(forEntityName: "CoinObject", in: context) else {
            return nil
        }
        
        self.init(entity: brandsEntity, insertInto: context)
        self.name = name
        self.price = price
        self.iconUrl = iconUrl
        self.uuid = uuid
        self.sparklineRaw = sparklineRaw
        self.isFavorite = isFavorite
    }
    
    var sparkline: [String] {
        get {
            sparklineRaw?.components(separatedBy: sparklineSeparator) ?? []
        }
        set{
            self.sparklineRaw = newValue.joined(separator: sparklineSeparator)
        }
    }

}

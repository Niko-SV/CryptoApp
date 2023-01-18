//
//  CoinEntity+CoreDataProperties.swift
//
//
//  Created by NikoS on 26.09.2022.
//
//

import Foundation
import CoreData


extension CoinObject {

    @nonobjc public class func fetchRequest(id: String) -> NSFetchRequest<CoinObject> {
        let request = NSFetchRequest<CoinObject>(entityName: "CoinObject")
        request.predicate = NSPredicate.init(format: "uuid == %@", id)
        return request
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var iconUrl: String?
    @NSManaged public var uuid: String?
    @NSManaged public var sparklineRaw: String?
    @NSManaged public var isFavorite: Bool

}

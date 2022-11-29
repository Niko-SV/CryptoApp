//
//  CoreDataStack.swift
//  CryptoApp
//
//  Created by NikoS on 26.09.2022.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func saveMainContext()
    func saveBackgorundContext()
}

class CoreDataStack: ObservableObject {
    static let instance: CoreDataStack = CoreDataStack()
    private let container = NSPersistentContainer(name: "CryptoDataContainer")
    let backgroundContext: NSManagedObjectContext
    var mainContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
        
        backgroundContext = container.newBackgroundContext()
        backgroundContext.automaticallyMergesChangesFromParent = true
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        mainContext.automaticallyMergesChangesFromParent = true
        mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
    }
    
}

extension CoreDataStack {
    
    func saveMainContext() {
        save(context: self.mainContext)
    }

    func saveBackgorundContext() {
        save(context: self.backgroundContext)
    }
    
    func removeData() {
        save(context: self.backgroundContext)
    }
    
    private func save(context: NSManagedObjectContext) {
        context.perform {
            guard context.hasChanges else {
                return
            }
            do {
                try context.save()
            } catch {
                context.rollback()
                let contextError = error as NSError
                assertionFailure(contextError.localizedDescription)
            }
        }
    }
}

//
//  CoreDataStorage.swift
//  CodableCoredata
//
//  Created by Nithin Kumar on 01/04/2020.
//  Copyright © 2020 Nithin Kumar. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStorage: NSObject {
    static let shared = CoreDataStorage()
    private override init() {
    }

    // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "DotaHero")
    
    container.loadPersistentStores(completionHandler: { (_, error) in
      guard let error = error as NSError? else { return }
      fatalError("Unresolved error: \(error), \(error.userInfo)")
    })
    
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.undoManager = nil
    container.viewContext.shouldDeleteInaccessibleFaults = true
    
    container.viewContext.automaticallyMergesChangesFromParent = true
    
    return container
  }()
    
    func managedObjectContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func clearStorage(forEntity entity: String) {
        let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }

        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let entities = try managedObjectContext.fetch(fetchRequest)
                for entity in entities {
                    managedObjectContext.delete(entity as! NSManagedObject)
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedObjectContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }
}

//
//  FavorisManager.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/23/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import Foundation
import CoreData

public class FavorisManager {
 
    let modelName: String = "FavorisDataModel"
    
    //Init PersistenStoreCoordinator
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        print("persistent")
        return persistentStoreCoordinator
    }()
    
    
    //Init managedObjectContext
    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        print("context")
        return managedObjectContext
    }()
    
    //Init managedObjectModel
    lazy var managedObjectModel: NSManagedObjectModel = {
        let podBundle = Bundle(for: FavorisManager.self)
        guard let modelURL = podBundle.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        print("model")
        return managedObjectModel
    }()
    
    // Create new favoris and return it
    public func newFavoris() -> Favoris {
        let favoris = NSEntityDescription.insertNewObject(forEntityName: "Favoris", into: self.managedObjectContext) as! Favoris
        return favoris
    }
    
    // Return all favoris
    public func getAllFavoris() -> [Favoris] {
        let favorisFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favoris")
        let fetchedFavoris: [Favoris]
        do {
            fetchedFavoris = try self.managedObjectContext.fetch(favorisFetchRequest) as! [Favoris]
        } catch {
            fatalError("Failed to fetch articles: \(error)")
        }
        return fetchedFavoris
    }
    
    // Remove favoris
    public func removeFavoris(favoris: Favoris) {
        self.managedObjectContext.delete(favoris)
    }
    
    // Save modification
    public func save() {
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    // Return all Favoris for a given Id
    public func getFavoris(withId id: Int) -> [Favoris] {
        let favorisFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favoris")
        favorisFetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
        let fetchedFavoris: [Favoris]
        do {
            fetchedFavoris = try self.managedObjectContext.fetch(favorisFetchRequest) as! [Favoris]
        } catch {
            fatalError("Failed to fetch favoris: \(error)")
        }
        return fetchedFavoris
    }
    
    public init() {
        
    }
}

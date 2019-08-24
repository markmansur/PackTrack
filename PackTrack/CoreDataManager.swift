//
//  CoreDataManager.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-17.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PackTrackModels")
        
        container.loadPersistentStores { (_, err) in
            if let err = err {
                fatalError("Failed to load persistent store: \(err)")
            }
        }
        return container
    }()
    
    
    func fetchPackages() -> [Package] {
        let fetchRequest = NSFetchRequest<Package>(entityName: "Package")
        let context = persistentContainer.viewContext
        
        do {
            let packages = try context.fetch(fetchRequest)
            return packages
        } catch let fetchErr {
            print("Failed to fetch packages: ", fetchErr)
            return []
        }
    }
    
    func deleteAllPackages() {
        let fetchRequest = NSFetchRequest<Package>(entityName: "Package")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        let context = persistentContainer.viewContext
        
        do {
            try context.execute(deleteRequest)
        } catch let delError {
            print("Failed to delete packages: ", delError)
        }
        
    }
    
    func addPackage(name: String, trackingNumber: String) -> Package {
        let context = persistentContainer.viewContext
        let package = NSEntityDescription.insertNewObject(forEntityName: "Package", into: context) as! Package
        package.setValuesForKeys(["name": name, "trackingNumber": trackingNumber])
        
        saveContext()
        return package
    }
    
    func updatePackage(package: Package, withJSON trackingJson: trackingResponseJSON) {
        package.status = trackingJson.trackingStatus?.status
        saveContext()
    }
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch let saveErr {
            fatalError("Failed to save package: \(saveErr)")
        }
    }
}

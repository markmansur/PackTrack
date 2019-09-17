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
    
    func addPackage(name: String, trackingNumber: String, trackingJson: trackingResponseJSON? = nil) -> Package {
        let context = persistentContainer.viewContext
        
        let package = Package(context: context)
        package.name = name
        package.trackingNumber = trackingNumber
        package.status = trackingJson?.trackingStatus?.status
        
        trackingJson?.trackingHistory?.forEach({ (trackingStatusJSON) in
            let context = persistentContainer.viewContext
            
            let trackingStatus = TrackingStatus(context: context)
            trackingStatus.status = trackingStatusJSON.status
            trackingStatus.statusDetails = trackingStatusJSON.statusDetails
            if let dateString = trackingStatusJSON.statusDate {
                trackingStatus.statusDate = getDate(date: dateString)
            }
            package.addToTrackingHistory(trackingStatus)
        })
        
        saveContext()
        return package
    }
    
    func updatePackage(package: Package, trackingJson: trackingResponseJSON) {
        package.status = trackingJson.trackingStatus?.status
        package.trackingHistory = nil // remove any current tracking history.
        
        trackingJson.trackingHistory?.forEach({ (trackingStatusJSON) in
            let context = persistentContainer.viewContext
            
            let trackingStatus = TrackingStatus(context: context)
            trackingStatus.status = trackingStatusJSON.status
            trackingStatus.statusDetails = trackingStatusJSON.statusDetails
            if let dateString = trackingStatusJSON.statusDate {
                trackingStatus.statusDate = getDate(date: dateString)
            }
            package.addToTrackingHistory(trackingStatus)
        })
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
    
    private func getDate(date: String) -> Date? {
        // remove the milliseconds portion from the string, otherwise formatter fails...
        var newDateString = date.components(separatedBy: ".")[0]
        newDateString.append("Z")
        
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: newDateString)
    }
}

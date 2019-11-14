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
    
    func addPackage(name: String, trackingNumber: String, carrier: String, trackingJson: trackingResponse? = nil) -> Package {
        let context = persistentContainer.viewContext
        
        let package = Package(context: context)
        package.name = name
        package.trackingNumber = trackingNumber
        package.carrier = carrier
        package.status = trackingJson?.checkpoints?.last?.tag
        
        trackingJson?.checkpoints?.forEach({ (checkpoint) in
            let context = persistentContainer.viewContext
            
            let trackingStatus = TrackingStatus(context: context)
            trackingStatus.status = checkpoint.tag
            trackingStatus.statusDetails = checkpoint.message
            if let dateString = checkpoint.time {
                trackingStatus.statusDate = getDate(date: dateString)
            }
            let trackingStatusLocation = TrackingStatusLocation(context: context)
            trackingStatusLocation.city = checkpoint.city
            trackingStatusLocation.state = checkpoint.state
            trackingStatusLocation.country = checkpoint.country
            
            trackingStatus.location = trackingStatusLocation
            package.addToTrackingHistory(trackingStatus)
        })
        saveContext()
        
        saveContext()
        return package
    }
    
    func updatePackage(package: Package, trackingJson: trackingResponse) {
        package.status = trackingJson.checkpoints?.last?.tag
        package.trackingHistory = nil // remove any current tracking history.
        
        trackingJson.checkpoints?.forEach({ (checkpoint) in
            let context = persistentContainer.viewContext
            
            let trackingStatus = TrackingStatus(context: context)
            trackingStatus.status = checkpoint.tag
            trackingStatus.statusDetails = checkpoint.message
            if let dateString = checkpoint.time {
                trackingStatus.statusDate = getDate(date: dateString)
            }
            let trackingStatusLocation = TrackingStatusLocation(context: context)
            trackingStatusLocation.city = checkpoint.city
            trackingStatusLocation.state = checkpoint.state
            trackingStatusLocation.country = checkpoint.country
            
            trackingStatus.location = trackingStatusLocation
            package.addToTrackingHistory(trackingStatus)
        })
        saveContext()
    }
    
    func updateGeolocation(for trackingStatus: TrackingStatus, latitude: Double, longitude: Double) {
        let geoLocation = Geolocation(context: persistentContainer.viewContext)
        geoLocation.latitude = latitude
        geoLocation.longitude = longitude
        
        let location = trackingStatus.location
        location?.geolocation = geoLocation
        
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

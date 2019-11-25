//
//  PackagesViewModel.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-17.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import Foundation
protocol PackagesViewModelDelegate {
    func didUpdatePackages()
}

class PackagesViewModel {
    var packages = [Package]()
    
    var delegate: PackagesViewModelDelegate?
    
    let activeParcels    = 0
    let deliveredParcels = 0
    
    init() {
//        CoreDataManager.shared.deleteAllPackages()
        getCoreDataPackages()
    }
    
    private func getCoreDataPackages() {
        packages = CoreDataManager.shared.fetchPackages()
        delegate?.didUpdatePackages()
    }
    
    func updatePackages() {
        packages = CoreDataManager.shared.fetchPackages()
        let dispatchGroup = DispatchGroup()
        
        packages.forEach { (package) in
            dispatchGroup.enter()
            guard let trackingNumber = package.trackingNumber else { return }
            guard let carrier        = package.carrier else { return }
            
            BackendService.shared.getTrackingInfo(for: trackingNumber, carrier: carrier) { (trackingResponseJSON, error) in
                if let error = error {
                    fatalError("error updating package \(error)")
                }
                guard let trackingResponseJSON = trackingResponseJSON else { return }
                CoreDataManager.shared.updatePackage(package: package, trackingJson: trackingResponseJSON)
                
                (package.trackingHistory?.array as! [TrackingStatus]).forEach { (trackingStatus) in
                    let location      = trackingStatus.location
                    guard let city    = location?.city else { return }
                    guard let state   = location?.state else { return }
                    guard let country = location?.country else { return }
                    
                    GeocodingService.shared.getGeocode(city: city, state: state, country: country) { (coordinate, error) in
                        if let err = error {
                            print(err)
                        }
                        
                        guard let coordinate = coordinate else { return }
                        CoreDataManager.shared.updateGeolocation(for: trackingStatus, latitude: coordinate.latitude, longitude: coordinate.longitude)
                    }
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.delegate?.didUpdatePackages()
        }
    }
    
    private func updatePackage(package: Package) {
        guard let trackingNumber = package.trackingNumber else { return }
        guard let carrier        = package.carrier else { return }
        
        BackendService.shared.getTrackingInfo(for: trackingNumber, carrier: carrier) { (trackingResponseJSON, error) in
            if let error = error {
                fatalError("error updating package \(error)")
            }
            guard let trackingResponseJSON = trackingResponseJSON else { return }
            CoreDataManager.shared.updatePackage(package: package, trackingJson: trackingResponseJSON)
            
            // TODO: update geolocation as well
            
            DispatchQueue.main.async {
                self.delegate?.didUpdatePackages()
            }
        }
    }
    
    func addPackage(name: String, trackingNumber: String, carrier: String) {
        let package = CoreDataManager.shared.addPackage(name: name, trackingNumber: trackingNumber, carrier: carrier)
        packages.append(package)
        updatePackage(package: package)
    }
}

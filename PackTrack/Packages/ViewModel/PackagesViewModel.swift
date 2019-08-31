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
    
    let activeParcels = 0
    let deliveredParcels = 0
    
    init() {
//        CoreDataManager.shared.deleteAllPackages()
        updatePackages()
    }
    
    private func updatePackages() {
        packages = CoreDataManager.shared.fetchPackages()
        let dispatchGroup = DispatchGroup()
        
        packages.forEach { (package) in
            dispatchGroup.enter()
            guard let trackingNumber = package.trackingNumber else { return }
            ShippoService.shared.getTrackingInfo(for: trackingNumber) { (trackingResponseJSON, error) in
                if let error = error {
                    fatalError("error updating package \(error)")
                }
                guard let trackingResponseJSON = trackingResponseJSON else { return }
                CoreDataManager.shared.updatePackage(package: package, trackingJson: trackingResponseJSON)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.delegate?.didUpdatePackages()
        }
    }
    
    private func updatePackage(package: Package) {
        guard let trackingNumber = package.trackingNumber else { return }
        ShippoService.shared.getTrackingInfo(for: trackingNumber) { (trackingResponseJSON, error) in
            if let error = error {
                fatalError("error updating package \(error)")
            }
            guard let trackingResponseJSON = trackingResponseJSON else { return }
            CoreDataManager.shared.updatePackage(package: package, trackingJson: trackingResponseJSON)
            DispatchQueue.main.async {
                self.delegate?.didUpdatePackages()
            }
            
        }
    }
    
    func addPackage(name: String, trackingNumber: String) {
        let package = CoreDataManager.shared.addPackage(name: name, trackingNumber: trackingNumber)
        packages.append(package)
        updatePackage(package: package)
    }
}

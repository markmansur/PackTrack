//
//  PackagesController+CollectionView.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-14.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension PackagesController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? PackageCell) else { return UICollectionViewCell() }
        cell.package = viewModel?.packages[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.packages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.94, height: 225)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let packageController = PackageController()
        packageController.package = viewModel?.packages[indexPath.row]
        navigationController?.pushViewController(packageController, animated: true)
    }
}

//
//  PackageCell.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-12.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit
import GoogleMaps

class PackageCell: UICollectionViewCell {
    var package: Package? {
        didSet {
            nameLabel.text = package?.name
            trackingLabel.text = package?.trackingNumber
            
            switch package?.status {
            case "PRE_TRANSIT":
                statusLabel.text = "Pre transit"
            case "TRANSIT":
                statusLabel.text = "In transit"
            case "DELIVERED":
                statusLabel.text = "Delivered"
            case "RETURNED":
                statusLabel.text = "Returned"
            case "FAILURE":
                statusLabel.text = "Failure"
            default:
                statusLabel.text = "Unknown"
            }
            setupMapView()
            
        }
    }
    
    private func setupMapView() {
        var geolocations = [Geolocation]()
        let trackingHistory = package?.trackingHistory?.array as? [TrackingStatus]
        trackingHistory?.forEach({ (trackingStatus) in
            if let geolocation = trackingStatus.location?.geolocation {
                geolocations.append(geolocation)
            }
        })
        
        if let map = GMapsController(geolocations: geolocations).view {
            map.translatesAutoresizingMaskIntoConstraints = false

            addSubview(map)
            map.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.94).isActive = true
            map.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            map.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(frame.width * 0.03)).isActive = true
            map.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45).isActive = true
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trackingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .darkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let carrierImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 5
    }
    
    private func setupSubviews() {
        // labels
        let labelsStackView = UIStackView(arrangedSubviews: [
            nameLabel,
            trackingLabel,
            statusLabel
        ])
        labelsStackView.axis    = .vertical
        labelsStackView.spacing = 6
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(labelsStackView)
        labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        labelsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        
        addSubview(carrierImageView)
        carrierImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        carrierImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        carrierImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        carrierImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

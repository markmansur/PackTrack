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
            setupCarrierImage()
            
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
    
    private func setupCarrierImage() {
        var imageName: String?
        
        switch package?.carrier {
        case Carrier.ups.rawValue:
            imageName = "ups-logo"
        case Carrier.dhl.rawValue:
            imageName = "dhl-logo"
        case Carrier.fedex.rawValue:
            imageName = "fedex-logo"
        case Carrier.usps.rawValue:
            imageName = "usps-logo"
        default:
            imageName = nil
        }
        
        if let imageName = imageName {
            carrierImageView.image = UIImage(named: imageName)
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
    
    private let carrierBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.darkBlue.withAlphaComponent(0.95).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 30
        view.layer.shadowOpacity = 0.17
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let carrierImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.75
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
        
        addSubview(carrierBackgroundView)
        carrierBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        carrierBackgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        carrierBackgroundView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        carrierBackgroundView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        carrierBackgroundView.addSubview(carrierImageView)
        carrierImageView.centerXAnchor.constraint(equalTo: carrierBackgroundView.centerXAnchor).isActive = true
        carrierImageView.centerYAnchor.constraint(equalTo: carrierBackgroundView.centerYAnchor).isActive = true
        carrierImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        carrierImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

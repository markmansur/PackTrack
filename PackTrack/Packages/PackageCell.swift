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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mapView: UIView = {
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let view = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        view.padding = padding
        
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        do {
          // Set the map style by passing the URL of the local file.
          if let styleURL = Bundle.main.url(forResource: "mapStyle", withExtension: "json") {
            view.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
          } else {
            NSLog("Unable to find style.json")
          }
        } catch {
          NSLog("One or more of the map styles failed to load. \(error)")
        }

        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = view

        return view
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
        let labelsStackView = UIStackView(arrangedSubviews: [
            nameLabel,
            trackingLabel,
            statusLabel
        ])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 6
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(labelsStackView)
        
        labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        labelsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        
        addSubview(mapView)
        mapView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.94).isActive = true
        mapView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(frame.width * 0.03)).isActive = true
        mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  PackageCell.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-12.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class PackageCell: UICollectionViewCell {
    var package: Package? {
        didSet {
            nameLabel.text = package?.name
            trackingLabel.text = package?.trackingNumber
            statusLabel.text = package?.status
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
        let view = UIView()
        view.backgroundColor = .mapBlue
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
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

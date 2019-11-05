//
//  PackageController.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-14.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit
import GoogleMaps

class PackageController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var package: Package? {
        didSet {
            packageNameLabel.text = package?.name
            trackingNumLabel.text = package?.trackingNumber
            daysLeftView.daysLeft = 4
            
            switch package?.status {
            case "InfoReceived":
                packageStatusLabel.text = "Info received"
            case "InTransit":
                packageStatusLabel.text = "In transit"
            case "Delivered":
                packageStatusLabel.text = "Delivered"
            case "OutForDelivery":
                packageStatusLabel.text = "Out for delivery"
            case "Exception":
                packageStatusLabel.text = "Exception"
            default:
                packageStatusLabel.text = "Unknown"
            }
        }
    }
    
    let packageNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let trackingNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Tracking number"
        label.textColor = .customLightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let trackingNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customWhite
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let whiteCard: UIView = {
        let view = UIView(frame: CGRect())
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack(tapGestureRecognizer:))))
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftArrowImageView: UIImageView = {
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)
            let symbolImage = UIImage(systemName: "arrow.left", withConfiguration: config)
            let imageView = UIImageView(image: symbolImage)
            imageView.tintColor = .white
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack(tapGestureRecognizer:))))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        } else {
            return UIImageView()
        }
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightBlue
        label.text = "Status"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let packageStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = .darkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let daysLeftView = DaysLeftView(daysLeft: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        setupBackImageView()
        setupPackageNameLabel()
        setupTrackingNumberLabel()
        setupWhiteCard()
        setupMapVC()
        setupTrackingHistoryController()
        setupStatusViews()
        view.backgroundColor = .darkBlue
    }
    
    private func setupMapVC() {
        var geolocations = [Geolocation]()
        let trackingHistory = package?.trackingHistory?.array as? [TrackingStatus]
        trackingHistory?.forEach({ (trackingStatus) in
            if let geolocation = trackingStatus.location?.geolocation {
                geolocations.append(geolocation)
            }
        })
        
        let mapVC = GMapsController(geolocations: geolocations)
        self.addChild(mapVC)
        
        self.view.addSubview(mapVC.view)
        mapVC.didMove(toParent: self)
        mapVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        mapVC.view.centerYAnchor.constraint(equalTo: whiteCard.topAnchor).isActive = true
        mapVC.view.centerXAnchor.constraint(equalTo: whiteCard.centerXAnchor).isActive = true
        mapVC.view.widthAnchor.constraint(equalTo: whiteCard.widthAnchor, multiplier: 0.95).isActive = true
        mapVC.view.heightAnchor.constraint(equalToConstant: 230).isActive = true
    }
    
    private func setupBackImageView() {
        view.addSubview(leftArrowImageView)
        leftArrowImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        leftArrowImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    }
    
    private func setupPackageNameLabel() {
        view.addSubview(packageNameLabel)
        packageNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        packageNameLabel.topAnchor.constraint(equalTo: leftArrowImageView.topAnchor).isActive = true
    }
    
    private func setupTrackingNumberLabel() {
        let stackView = UIStackView(arrangedSubviews: [
            trackingNumberLabel,
            trackingNumLabel
        ])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: leftArrowImageView.bottomAnchor, constant: 20).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftArrowImageView.leftAnchor).isActive = true
    }
    
    private func setupWhiteCard() {
        view.addSubview(whiteCard)
        whiteCard.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.93).isActive = true
        whiteCard.heightAnchor.constraint(equalToConstant: 540).isActive = true
        whiteCard.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    @objc func handleBack(tapGestureRecognizer: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupStatusViews() {
        // status labels
        let labelsStackView = UIStackView(arrangedSubviews: [statusLabel, packageStatusLabel])
        labelsStackView.axis = .vertical
        
        // horizontal stack view holding labels stack view and daysLeftView
        let horizontalStackView = UIStackView(arrangedSubviews: [labelsStackView, daysLeftView])
        horizontalStackView.alignment = .bottom
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(horizontalStackView)
        horizontalStackView.centerYAnchor.constraint(equalTo: whiteCard.centerYAnchor, constant: -75).isActive = true
        horizontalStackView.leftAnchor.constraint(equalTo: whiteCard.leftAnchor, constant: 14).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: whiteCard.rightAnchor, constant: -14).isActive = true
    }
    
    private func setupTrackingHistoryController() {
        let childVC = TrackingHistoryController(package: self.package)

        self.addChild(childVC)

        self.view.addSubview(childVC.view)
        childVC.didMove(toParent: self)

        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        childVC.view.topAnchor.constraint(equalTo: whiteCard.centerYAnchor, constant: -20).isActive = true
        childVC.view.leftAnchor.constraint(equalTo: whiteCard.leftAnchor, constant: 6).isActive = true
        childVC.view.rightAnchor.constraint(equalTo: whiteCard.rightAnchor, constant: -14).isActive = true
        childVC.view.bottomAnchor.constraint(equalTo: whiteCard.bottomAnchor).isActive = true
    }
}

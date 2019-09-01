//
//  PackageController.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-14.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class PackageController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var package: Package? {
        didSet {
            packageNameLabel.text = package?.name
            trackingNumLabel.text = package?.trackingNumber
            
            switch package?.status {
            case "PRE_TRANSIT":
                packageStatusLabel.text = "Pre transit"
            case "TRANSIT":
                packageStatusLabel.text = "In transit"
            case "DELIVERED":
                packageStatusLabel.text = "Delivered"
            case "RETURNED":
                packageStatusLabel.text = "Returned"
            case "FAILURE":
                packageStatusLabel.text = "Failure"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        setupBackImageView()
        setupPackageNameLabel()
        setupTrackingNumberLabel()
        setupWhiteCard()
        setupTrackingHistoryController()
        setupStatusViews()
        view.backgroundColor = .darkBlue
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
        whiteCard.heightAnchor.constraint(equalToConstant: 550).isActive = true
        whiteCard.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    @objc func handleBack(tapGestureRecognizer: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupStatusViews() {
        // status labels
        let labelsStackView = UIStackView(arrangedSubviews: [statusLabel, packageStatusLabel])
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.axis = .vertical
        
        view.addSubview(labelsStackView)
        labelsStackView.centerYAnchor.constraint(equalTo: whiteCard.centerYAnchor, constant: -68).isActive = true
        labelsStackView.leftAnchor.constraint(equalTo: whiteCard.leftAnchor, constant: 8).isActive = true
        
        //TODO: setup 'daysLeftView'
    }
    
    private func setupTrackingHistoryController() {
        let childVC = TrackingHistoryController(package: self.package)

        self.addChild(childVC)

        self.view.addSubview(childVC.view)
        childVC.didMove(toParent: self)

        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        childVC.view.topAnchor.constraint(equalTo: whiteCard.centerYAnchor, constant: -20).isActive = true
        childVC.view.leftAnchor.constraint(equalTo: whiteCard.leftAnchor).isActive = true
        childVC.view.widthAnchor.constraint(equalTo: whiteCard.widthAnchor).isActive = true
        childVC.view.bottomAnchor.constraint(equalTo: whiteCard.bottomAnchor).isActive = true
    }
}

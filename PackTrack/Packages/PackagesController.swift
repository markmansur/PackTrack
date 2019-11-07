//
//  ViewController.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-10.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class PackagesController: UICollectionViewController, PackagesViewModelDelegate, AddPackageModalDelegate {
    var viewModel: PackagesViewModel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    let activePackagesNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textColor = .customGreen
        label.font = UIFont.boldSystemFont(ofSize: 42)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deliveredPackagesNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.textColor = .customLightGray
        label.font = UIFont.boldSystemFont(ofSize: 42)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activePackagesLabel: UILabel = {
        let label = UILabel()
        label.text = "Active parcels"
        label.textColor = .customGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deliveredPackagesLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivered parcels"
        label.textColor = .customLightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        viewModel = PackagesViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel = PackagesViewModel()
        viewModel?.delegate = self 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .customWhite
        setupBlueBackgroundView()
        setupCountLabels()
        setupCollectionView()
        setupAddButton()
        configureRefreshControl()
    }
    
    private func setupBlueBackgroundView() {
        let blueBackgroundView = BlueBackgroundView(frame: view.frame)
        view.addSubview(blueBackgroundView)
    }
    
    private func setupCountLabels() {
        let activePackagesStackView = UIStackView(arrangedSubviews: [
            activePackagesNumberLabel,
            activePackagesLabel
        ])
        activePackagesStackView.axis = .vertical
        
        let deliveredPackagesStackView = UIStackView(arrangedSubviews: [
            deliveredPackagesNumberLabel,
            deliveredPackagesLabel
        ])
        deliveredPackagesStackView.axis = .vertical
        
        let horizontalStackView = UIStackView(arrangedSubviews: [
            activePackagesStackView,
            deliveredPackagesStackView
        ])
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.spacing = 35
        
        view.addSubview(horizontalStackView)
        horizontalStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
    }
    
    private func setupCollectionView() {
        view.bringSubviewToFront(collectionView)
        collectionView.backgroundColor = .clear
        
        collectionView.register(PackageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func handleAdd() {
        let vc = AddPackageModalViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: false, completion: nil)
    }
    
    private func setupAddButton() {
        let addPackageButton = AddPackageButton()
        addPackageButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        
        view.addSubview(addPackageButton)
        addPackageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPackageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
    }
    
    func didAddPackage(name: String, trackingNumber: String, carrier: String) {
        viewModel?.addPackage(name: name, trackingNumber: trackingNumber, carrier: carrier)
        collectionView.reloadData()
    }
    
    func didUpdatePackages() {
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }
    
    private func configureRefreshControl() {
        let refreshControl       = UIRefreshControl()
        refreshControl.tintColor = .white
        
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        viewModel?.updatePackages()
    }
}


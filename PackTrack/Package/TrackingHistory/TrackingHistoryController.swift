//
//  TrackingHistoryController.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-25.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class TrackingHistoryController: UITableViewController {
    let viewModel: TrackingHistoryViewModel?
    
    
    init(package: Package?) {
        viewModel = TrackingHistoryViewModel(trackingHistory: package?.trackingHistory?.array as! [TrackingStatus])
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupTableView()
        tableView.register(TrackingHistoryCell.self, forCellReuseIdentifier: "cellId")
    }
    
    
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

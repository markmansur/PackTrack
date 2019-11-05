//
//  DaysLeftView.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-09-01.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class DaysLeftView: UIView {
    var daysLeft: Int {
        didSet {
            label.text = "\(daysLeft) days left"
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(daysLeft: Int) {
        self.daysLeft = daysLeft
        super.init(frame: CGRect.null)
        
        setupView()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .darkBlue
        
        layer.cornerRadius = 45 / 2
        
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        widthAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    private func setupSubviews() {
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

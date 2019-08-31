//
//  TrackingHistoryCell.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-25.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class TrackingHistoryCell: UITableViewCell {
    var trackingStatus: TrackingStatus? {
        didSet {
            statusLabel.text = trackingStatus?.statusDetails
        }
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "04 Sept 2019"
        label.textColor = .dateTimeColor
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "04:09"
        label.textColor = .dateTimeColor
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Departed from local distribution centre"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        let lineView = UIView()
        lineView.backgroundColor = .lineSeparator
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 4).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        let dateTimeStackView = UIStackView(arrangedSubviews: [dateLabel, timeLabel, lineSeparatorView])
        dateTimeStackView.axis = .vertical
        dateTimeStackView.distribution = .fillEqually
        dateTimeStackView.spacing = 8
        dateTimeStackView.setCustomSpacing(4, after: timeLabel)
        dateTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(dateTimeStackView)
        
        dateTimeStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        dateTimeStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        dateTimeStackView.widthAnchor.constraint(equalToConstant: 90).isActive = true

        addSubview(statusLabel)
        statusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        statusLabel.leftAnchor.constraint(equalTo: dateTimeStackView.rightAnchor, constant: 8).isActive = true
        statusLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
}
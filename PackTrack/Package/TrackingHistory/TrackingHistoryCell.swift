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
            if let date = trackingStatus?.statusDate {
                print(date)
                dateLabel.text = formatDate(date, withFormatter: "dd MMM yyyy")
                timeLabel.text = formatDate(date, withFormatter: "hh':'mm")
                
                let location = trackingStatus?.location
                if let city = location?.city, let state = location?.state {
                    locationLabel.text = "\(city), \(state)"
                }
            }
        }
    }
    
    var showLineSeparatorView: Bool = true {
        didSet {
            removeSubviews()
            setupSubviews()
        }
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .dateTimeColor
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .dateTimeColor
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Departed from local distribution centre"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lineSeparatorView: UIView = {
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
        isUserInteractionEnabled = false
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        let dateTimeStackView = UIStackView(arrangedSubviews: [dateLabel, timeLabel])
        
        if showLineSeparatorView {
            dateTimeStackView.addArrangedSubview(lineSeparatorView)
        }
        
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
        
        addSubview(locationLabel)
        locationLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 6).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: dateTimeStackView.rightAnchor, constant: 8).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    
    private func formatDate(_ date: Date, withFormatter format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}

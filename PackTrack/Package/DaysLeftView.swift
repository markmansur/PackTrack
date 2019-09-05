//
//  DaysLeftView.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-09-01.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class DaysLeftView: UIView {
    let label: UILabel = {
        let label = UILabel()
        label.text = "6 days left"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(daysLeft: Int) {
        super.init(frame: CGRect.null)
        backgroundColor = .darkBlue
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

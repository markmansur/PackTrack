//
//  UILabel+helpers.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-09-19.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        translatesAutoresizingMaskIntoConstraints = false
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    convenience init(text: String, font: UIFont, textColor: UIColor = .black) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

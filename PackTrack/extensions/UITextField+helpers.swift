//
//  UITextField+helpers.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-11-03.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension UITextField {
    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        translatesAutoresizingMaskIntoConstraints = false
    }
}

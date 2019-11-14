//
//  UIButton+helpers.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-09-18.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String, titleColor: UIColor, target: Any?, action: Selector, touchEvent: UIControl.Event) {
        self.init()
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        addTarget(target, action: action, for: touchEvent)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}

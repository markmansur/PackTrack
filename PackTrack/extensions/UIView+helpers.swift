//
//  UIView+helpers.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-15.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

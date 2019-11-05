//
//  UIStackView+helpers.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-09-24.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension UIStackView {
    // must be used after axis is set on UIStackView
    func addSeparators(color: UIColor) {
        var i = arrangedSubviews.count - 1
        while i > 0 {
            let separatorView = createSeparatorView(color: color)
            self.insertArrangedSubview(separatorView, at: i)
            i = i - 1
        }
    }
    
    private func createSeparatorView(color: UIColor) -> UIView{
        let separatorView = UIView()
        separatorView.backgroundColor = color
        switch axis {
        case .vertical:
            separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        default:
            separatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        }
        return separatorView
    }
}

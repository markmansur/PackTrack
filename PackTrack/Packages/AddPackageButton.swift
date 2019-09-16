//
//  AddPackageButton.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-09-05.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class AddPackageButton: UIButton {
    
    let plusImageView: UIImageView = {
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 26, weight: .semibold, scale: .medium)
            let symbolImage = UIImage(systemName: "plus", withConfiguration: config)
            let imageView = UIImageView(image: symbolImage)
            imageView.tintColor = .darkBlue
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        } else {
            return UIImageView()
        }
    }()
    
    init() {
        super.init(frame: CGRect.null)
        
        setupView()
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        layer.cornerRadius = 35
        
        // autolayout
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 70).isActive = true
        widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        // plusImageView
        addSubview(plusImageView)
        plusImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        plusImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupShadow() {
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1
        layer.shadowRadius = 2
        layer.shadowColor = UIColor.transparentBorder.cgColor
    }
}

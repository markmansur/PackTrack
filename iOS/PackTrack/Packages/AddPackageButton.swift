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
        setupBorder()
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
    
    private func setupBorder() {
        layer.borderColor = UIColor.transparentBorder.withAlphaComponent(0.4).cgColor
        layer.borderWidth = 3
    }
    
    private func setupShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 15)
        layer.shadowOpacity = 0.55
        layer.shadowRadius = 15
        layer.shadowColor = UIColor.darkBlue.withAlphaComponent(0.5).cgColor
    }
}

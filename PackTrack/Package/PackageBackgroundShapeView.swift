//
//  PackagesBackgroundShapeView.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-11-06.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class PackageBackgroundShapeView: UIView {
    var path: UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.customWhite.withAlphaComponent(0.2).setFill()
        setupLargeInnerTriangle()
        path?.fill()
        setupSmallInnerTriangle()
        path?.fill()
        
        UIColor.customWhite.withAlphaComponent(0.15).setFill()
        setupLargeOutterTriangle()
        path?.fill()
        setupSmallOutterTriangle()
        path?.fill()
    }
    
    private func setupLargeInnerTriangle() {
        path = UIBezierPath()
        
        path?.move(to: CGPoint(x: 0.0, y: frame.height / 2))
        path?.addLine(to: CGPoint(x: 0.0, y: frame.height))
        path?.addLine(to: CGPoint(x: self.frame.width, y: frame.height))
        path?.addLine(to: CGPoint(x: self.frame.width, y: frame.height - 75))
        
        path?.close()
    }
    
    private func setupLargeOutterTriangle() {
        path = UIBezierPath()
        
        path?.move(to: CGPoint(x: 0.0, y: frame.height / 2 - 30))
        path?.addLine(to: CGPoint(x: 0.0, y: frame.height))
        path?.addLine(to: CGPoint(x: self.frame.width, y: frame.height))
        path?.addLine(to: CGPoint(x: self.frame.width, y: frame.height - 75 - 30))
        
        path?.close()
    }
    
    private func setupSmallInnerTriangle() {
        path = UIBezierPath()
        
        path?.move(to: CGPoint(x: frame.width - 20, y: 100))
        path?.addLine(to: CGPoint(x: frame.width, y: 80))
        path?.addLine(to: CGPoint(x: frame.width, y: 120))
        
        path?.close()
    }
    
    private func setupSmallOutterTriangle() {
        path = UIBezierPath()
        
        path?.move(to: CGPoint(x: frame.width - 20 - 25, y: 100))
        path?.addLine(to: CGPoint(x: frame.width, y: 55))
        path?.addLine(to: CGPoint(x: frame.width, y: 145))
        
        path?.close()
    }
    
    
}

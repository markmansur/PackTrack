//
//  BlueBackgroundView.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-11-06.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class BlueBackgroundView: UIView {
    var path: UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.darkBlue.setFill()
        setupBlueRectangle()
        path?.fill()
        setupCurve()
        path?.fill()
        
        UIColor.customWhite.withAlphaComponent(0.2).setFill()
        setupInnerTriangle()
        path?.fill()
        
        UIColor.customWhite.withAlphaComponent(0.15).setFill()
        setupOuterTriange()
        path?.fill()
        
    }
    
    private func setupBlueRectangle() {
        path = UIBezierPath()
        path?.move(to: CGPoint(x: 0, y: 0))
        path?.addLine(to: CGPoint(x: 0, y: 230))
        path?.addLine(to: CGPoint(x: frame.width, y: 230))
        path?.addLine(to: CGPoint(x: frame.width, y: 0))
        path?.close()
    }
    
    private func setupCurve() {
        path = UIBezierPath()
        path?.move(to: CGPoint(x: 0, y: 230))
        path?.addQuadCurve(to: CGPoint(x: frame.width, y: 230), controlPoint: CGPoint(x: frame.width / 2, y: 360))
    }
    
    private func setupInnerTriangle() {
        path = UIBezierPath()
        path?.move(to: CGPoint(x: frame.width, y: 85))
        path?.addLine(to: CGPoint(x: 90, y: 330))
        path?.addLine(to: CGPoint(x: frame.width, y: 330))
        path?.close()
    }
    
    private func setupOuterTriange() {
        path = UIBezierPath()
        path?.move(to: CGPoint(x: frame.width, y: 55))
        path?.addLine(to: CGPoint(x: 60, y: 330))
        path?.addLine(to: CGPoint(x: frame.width, y: 330))
        path?.close()
    }
    
}
    
extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}

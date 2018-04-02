//
//  LoopView+IBDesignable.swift
//  Loch
//
//  Created by Eric Cormack on 4/1/18.
//  Copyright © 2018 the Odin Spire. All rights reserved.
//

import UIKit

extension LoopView {
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        let placeholderLayer = CAShapeLayer()
//        placeholderLayer.bounds = bounds
        
        let placeholderPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: (bounds.width * loopScale) / 2, startAngle: 1.5 * .pi, endAngle: 0.67 * .pi, clockwise: true)
        
        placeholderLayer.path = placeholderPath.cgPath
        
        placeholderLayer.lineCap = kCALineCapRound
        placeholderLayer.lineWidth = 5.0
        placeholderLayer.strokeColor = timerMainColor
        
        placeholderLayer.fillColor = UIColor.clear.cgColor
        
        placeholderLayer.shadowOffset = CGSize(width: 0, height: 0)
        placeholderLayer.shadowRadius = 5.0
        placeholderLayer.shadowOpacity = 1
        placeholderLayer.shadowColor = timerMainColor
        
        layer.addSublayer(placeholderLayer)
    }
    
    @IBInspectable var workTimerColor: UIColor {
        get {
            return UIColor(cgColor: timerMainColor)
        }
        
        set {
            timerMainColor = newValue.cgColor
        }
    }
}

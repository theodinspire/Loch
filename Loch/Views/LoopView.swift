//
//  LoopView.swift
//  Loch
//
//  Created by Eric Cormack on 3/16/18.
//  Copyright © 2018 the Odin Spire. All rights reserved.
//

import UIKit

@IBDesignable
class LoopView: UIView {
    var trackColor: UIColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
    var trackShade: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    var trackLight: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
    
    var timerColor: UIColor = UIColor.white
    
    var loopScale: CGFloat = 0.75
    var lineWidth: CGFloat = 5
    
    lazy var path: UIBezierPath = initializePath()
    lazy var animationLayer: CAShapeLayer = initializeAnimationLayer()
    
    override func draw(_ rect: CGRect) {
        layer.addSublayer(animationLayer)
        
        let downRect = CGRect(origin: rect.origin + (0.0, 1.0), size: rect.size)
        let downPath = UIBezierPath(ovalIn: makeLoopRect(for: downRect))
        downPath.lineWidth = lineWidth
        trackLight.setStroke()
        downPath.stroke()
        
        let upRect = CGRect(origin: rect.origin - (0.0, 1.0), size: rect.size)
        let upPath = UIBezierPath(ovalIn: makeLoopRect(for: upRect))
        upPath.lineWidth = lineWidth
        trackShade.setStroke()
        upPath.stroke()
        
        path.lineWidth = lineWidth
        trackColor.setStroke()
        path.stroke()
        
        initializeTimer()
    }
    
    func initializeTimer() {
    }
    
    func animateTimer(over duration: TimeInterval) {
        animationLayer.setValue(0, forKey: "strokeStart")
        
        let head = CABasicAnimation(keyPath: "strokeEnd")
        head.fromValue = CGFloat.leastNormalMagnitude
        head.toValue = 1
        head.duration = duration
        head.fillMode = kCAFillModeForwards
        head.isRemovedOnCompletion = false
        
        animationLayer.add(head, forKey: "strokeEnd")
    }
    
    func animateTimerReset() {
        let tail = CABasicAnimation(keyPath: "strokeStart")
        tail.fromValue = 0
        tail.toValue = CGFloat.oneMinusEpsilon
        tail.duration = 0.5
        tail.fillMode = kCAFillModeForwards
        tail.isRemovedOnCompletion = false

        animationLayer.add(tail, forKey: "strokeStart")
    }
    
    //  Initializers
    private func makeLoopRect(for rect: CGRect) -> CGRect {
        let dimension = min(rect.height, rect.width) * loopScale
        let size = CGSize(width: dimension, height: dimension)
        let offset = CGPoint(x: (rect.width - dimension) / 2, y: (rect.height - dimension) / 2)
        
        return CGRect(origin: offset + rect.origin, size: size)
    }
    
    private func initializePath() -> UIBezierPath {
        return UIBezierPath(ovalIn: makeLoopRect(for: bounds))
    }
    
    private func initializeAnimationLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        let transform = CGAffineTransform(rotationAngle: 1.5 * CGFloat.pi).translatedBy(x: -bounds.width, y: 0)
        
        layer.path = path.cgPath
        layer.setAffineTransform(transform)
        
        layer.strokeColor = timerColor.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = kCALineCapRound
        layer.lineWidth = lineWidth
        
        layer.shadowColor = timerColor.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
        layer.setValue(CGFloat.leastNormalMagnitude, forKey: "strokeEnd")
        
        return layer
    }
}

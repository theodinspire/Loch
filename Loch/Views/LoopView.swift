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
    
    var timerMainColor: CGColor = UIColor.white.cgColor
    
    var loopScale: CGFloat = 0.75
    var lineWidth: CGFloat = 5
    
    lazy var animationLayer: CAShapeLayer = initializedAnimationLayer()
    
    override func draw(_ rect: CGRect) {
        let downPath = initializePath(withDisplacement: CGPoint(x: 0, y: 1))
        downPath.lineWidth = lineWidth
        trackLight.setStroke()
        downPath.stroke()
        
        let upPath = initializePath(withDisplacement: CGPoint(x: 0, y: -1))
        upPath.lineWidth = lineWidth
        trackShade.setStroke()
        upPath.stroke()
        
        let path = initializePath()
        path.lineWidth = lineWidth
        trackColor.setStroke()
        path.stroke()
        
        animationLayer.strokeEnd = .leastNormalMagnitude
    }
    
    override func awakeFromNib() {
        layer.addSublayer(animationLayer)
//        animationLayer.strokeEnd = .leastNormalMagnitude
    }
    
    func animateTimer(over duration: TimeInterval) {
        animationLayer.removeAllAnimations()
        
        let head = CABasicAnimation(keyPath: "strokeEnd")
        head.toValue = 1
        head.duration = duration
        head.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        head.fillMode = kCAFillModeForwards
        head.isRemovedOnCompletion = false
        
        animationLayer.add(head, forKey: "strokeEnd")
    }
    
    func animateTimerReset() {
        let tail = CABasicAnimation(keyPath: "strokeStart")
        tail.toValue = CGFloat.oneMinusEpsilon
        tail.duration = 0.1
        tail.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        tail.fillMode = kCAFillModeForwards
        tail.isRemovedOnCompletion = false
        
        animationLayer.add(tail, forKey: "strokeStart")
    }
    
    //  Initializers
    func initializePath(withDisplacement vector: CGPoint = CGPoint.zero) -> UIBezierPath {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2) + vector
        let radius = min(bounds.width, bounds.height) * loopScale / 2

        return UIBezierPath(arcCenter: center, radius: radius, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)
    }
    
    func initializedAnimationLayer(endingAt point: CGFloat = .leastNormalMagnitude) -> CAShapeLayer {
        let layer = CAShapeLayer()
        
        layer.path = initializePath().cgPath
        
        layer.strokeColor = timerMainColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = kCALineCapRound
        layer.lineWidth = lineWidth
        
        layer.shadowColor = timerMainColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
        layer.strokeEnd = point
        
        return layer
    }
}

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
    var trackGround = UIColor.darkGray
    var trackShade = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    var trackLight = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
    
    var timerMainColor = UIColor.white.cgColor
    var timerBreakColor = UIColor.green.cgColor
    
    var loopScale: CGFloat = 0.75
    var lineWidth: CGFloat = 5
    
    var shadowBlurRadius: CGFloat = 5
    
    lazy var animationLayer: CAShapeLayer = initializedAnimationLayer()
    
    var currentState = TimerState.work
    var currentColor: CGColor {
        switch currentState {
        case .work:
            return timerMainColor
        default:
            return timerBreakColor
        }
    }
    
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
        trackGround.setStroke()
        path.stroke()
        
        animationLayer.strokeEnd = .leastNormalMagnitude
    }
    
    override func awakeFromNib() {
        layer.addSublayer(animationLayer)
//        animationLayer.strokeEnd = .leastNormalMagnitude
        
        super.awakeFromNib()
    }

    //  TODO: Combine Reset with animation start
    func animateTimer(over duration: TimeInterval) {
        animationLayer.strokeColor = currentColor
        animationLayer.shadowColor = currentColor
        
        animationLayer.removeAllAnimations()
        
        let head = CABasicAnimation(keyPath: "strokeEnd")
        head.toValue = 1
        head.duration = duration
        head.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        head.fillMode = kCAFillModeForwards
        head.isRemovedOnCompletion = false
        
        animationLayer.add(head, forKey: "strokeEnd")
    }
    
    func animateTimerReset(withNextState nextState: TimerState) {
        currentState = nextState
        
        let tail = CABasicAnimation(keyPath: "strokeStart")
        tail.toValue = CGFloat.oneMinusEpsilon
        let color = CABasicAnimation(keyPath: "strokeColor")
        color.toValue = currentColor
        let glow = CABasicAnimation(keyPath: "shadowColor")
        glow.toValue = currentColor
        
        let group = CAAnimationGroup()
        group.animations = [tail, color, glow]
        
        group.duration = 0.33
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        group.fillMode = kCAFillModeForwards
        group.isRemovedOnCompletion = false
        
        animationLayer.add(group, forKey: "strokeStart")
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
        
        layer.strokeColor = currentColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = kCALineCapRound
        layer.lineWidth = lineWidth
        
        layer.shadowColor = currentColor
        layer.shadowRadius = shadowBlurRadius
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
        layer.strokeEnd = point
        
        return layer
    }
}

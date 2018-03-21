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
    
    var path: UIBezierPath?
    var animationLayer: CAShapeLayer?
    
    override func draw(_ rect: CGRect) {
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
        
        path = UIBezierPath(ovalIn: makeLoopRect(for: rect))
        path?.lineWidth = lineWidth
        trackColor.setStroke()
        path?.stroke()
    }
    
    func animateTimer(over duration: TimeInterval) {
        if animationLayer == nil {
            animationLayer = CAShapeLayer()
            
            let aniPath = path?.copy() as? UIBezierPath
            
            let transform = CGAffineTransform(rotationAngle: 1.5 * CGFloat.pi).translatedBy(x: -bounds.width, y: 0)
            aniPath?.apply(transform)
            
            animationLayer?.path = aniPath?.cgPath
            animationLayer?.strokeColor = timerColor.cgColor
            animationLayer?.lineCap = kCALineCapRound
            animationLayer?.fillColor = UIColor.clear.cgColor
            animationLayer?.lineWidth = lineWidth
            animationLayer?.shadowColor = timerColor.cgColor
            animationLayer?.shadowRadius = 5.0
            animationLayer?.shadowOpacity = 1
        }
        
        let head = CABasicAnimation(keyPath: "strokeEnd")
        head.fromValue = 0
        head.toValue = 1
        head.duration = duration
        
        animationLayer?.add(head, forKey: "strokeEnd")
        layer.addSublayer(animationLayer!)
    }
    
    private func makeLoopRect(for rect: CGRect) -> CGRect {
        let dimension = min(rect.height, rect.width) * loopScale
        let size = CGSize(width: dimension, height: dimension)
        let offset = CGPoint(x: (rect.width - dimension) / 2, y: (rect.height - dimension) / 2)
        
        return CGRect(origin: offset + rect.origin, size: size)
    }
}

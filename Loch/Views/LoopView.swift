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
    
    var loopScale: CGFloat = 0.75
    var lineWidth: CGFloat = 3
    
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
        
        let path = UIBezierPath(ovalIn: makeLoopRect(for: rect))
        path.lineWidth = lineWidth
        trackColor.setStroke()
        path.stroke()
    }
    
    private func makeLoopRect(for rect: CGRect) -> CGRect {
        let dimension = min(rect.height, rect.width) * loopScale
        let size = CGSize(width: dimension, height: dimension)
        let offset = CGPoint(x: (rect.width - dimension) / 2, y: (rect.height - dimension) / 2)
        
        return CGRect(origin: offset + rect.origin, size: size)
    }
}

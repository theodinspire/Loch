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
    let trackColor = UIColor.black
    let loopScale: CGFloat = 0.75
    let lineWidth: CGFloat = 3
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: makeLoopRect(for: rect))
        path.lineWidth = lineWidth
        trackColor.setStroke()
        path.stroke()
    }
    
    private func makeLoopRect(for rect: CGRect) -> CGRect {
        let dimension = min(rect.height, rect.width) * loopScale
        let size = CGSize(width: dimension, height: dimension)
        let offset = CGPoint(x: (rect.width - dimension) / 2, y: (rect.height - dimension) / 2)
        
        return CGRect(origin: offset, size: size)
    }
}

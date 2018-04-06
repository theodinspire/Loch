//
//  CGPoint+VectorAddition.swift
//  Loch
//
//  Created by Eric Cormack on 3/18/18.
//  Copyright © 2018 the Odin Spire. All rights reserved.
//

import UIKit

extension CGPoint {
    // +
    static func +(this: CGPoint, that: CGPoint) -> CGPoint {
        return CGPoint(x: this.x + that.x, y: this.y + that.y)
    }
    
    static func +(this: (x: CGFloat, y: CGFloat), that: CGPoint) -> CGPoint {
        return CGPoint(x: this.x, y: this.y) + that
    }
    
    static func +(this: CGPoint, that: (x: CGFloat, y: CGFloat)) -> CGPoint {
        return that + this
    }
    
    // Scalar multiplication
    static func *(scalar: CGFloat, point: CGPoint) -> CGPoint {
        return CGPoint(x: scalar * point.x, y: scalar * point.y)
    }
    
    // -
    static prefix func -(this: CGPoint) -> CGPoint {
        return CGPoint(x: -this.x, y: -this.y)
    }
    
    static func -(this: CGPoint, that: CGPoint) -> CGPoint {
        return this + -that
    }
    
    static func -(this: (x: CGFloat, y: CGFloat), that: CGPoint) -> CGPoint {
        return this + -that
    }
    
    static func -(this: CGPoint, that: (x: CGFloat, y: CGFloat)) -> CGPoint {
        return this + (-that.x, -that.y)
    }
}

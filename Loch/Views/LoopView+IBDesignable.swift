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
        
        let fauxLayer = initializedAnimationLayer(endingAt: 0.67)
        
        layer.addSublayer(fauxLayer)
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

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
    
    //  Track
    @IBInspectable var loopScalePercent: Double {
        get { return 100 * Double(loopScale) }
        set { loopScale = CGFloat(newValue / 100) }
    }
    
    @IBInspectable var width: CGFloat {
        get { return lineWidth }
        set { lineWidth = newValue }
    }
    
    //  Timers
    @IBInspectable var workTimerColor: UIColor {
        get { return UIColor(cgColor: timerMainColor) }
        set { timerMainColor = newValue.cgColor }
    }
}

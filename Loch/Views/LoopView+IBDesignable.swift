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
    
    @IBInspectable var trackColor: UIColor {
        get { return trackGround }
        set { trackGround = newValue }
    }
    
    @IBInspectable var trackShadow: UIColor {
        get { return trackShade }
        set { trackShade = newValue }
    }
    
    @IBInspectable var trackHighlight: UIColor {
        get { return trackLight }
        set { trackLight = newValue }
    }
    
    //  Timers
    @IBInspectable var workTimerColor: UIColor {
        get { return UIColor(cgColor: timerMainColor) }
        set { timerMainColor = newValue.cgColor }
    }
    
    @IBInspectable var breakTimerColor: UIColor {
        get { return UIColor(cgColor: timerBreakColor)}
        set { timerBreakColor = newValue.cgColor }
    }
    
//    @IBInspectable var breakTimerColor: UIColor {
//
//    }
    
    @IBInspectable var glowBlurRadius: CGFloat {
        get { return shadowBlurRadius }
        set { shadowBlurRadius = newValue }
    }
}

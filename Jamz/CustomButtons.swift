//
//  CustomButtons.swift
//  Jamz
//
//  Created by Jimmy Nguyen on 1/28/16.
//  Copyright © 2016 Jimmy Nguyen. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomButtons: UIButton {
        
    // IBInspectable properties for the gradient colors
    @IBInspectable var bottomColor: UIColor = UIColor(red:0.98, green:0.49, blue:0.2, alpha:1)
    @IBInspectable var middleColor: UIColor = UIColor(red:0.98, green:0.85, blue:0.38, alpha:1)
    @IBInspectable var topColor: UIColor = UIColor(red:0.98, green:0.49, blue:0.2, alpha:1)
    @IBInspectable var bottomColorAlpha: CGFloat = 1.0
    @IBInspectable var middleColorAlpha: CGFloat = 1.0
    @IBInspectable var topColorAlpha: CGFloat = 1.0
        
    // IBInspectable properties for rounded corners and border color / width
    @IBInspectable var cornerSize: CGFloat = 0
    @IBInspectable var borderSize: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.blackColor()
    @IBInspectable var borderAlpha: CGFloat = 1.0
        
    override func drawRect(rect: CGRect) {
            
        // set up border and cornerRadius
        self.layer.cornerRadius = cornerSize
        self.layer.borderColor = borderColor.colorWithAlphaComponent(borderAlpha).CGColor
        self.layer.borderWidth = borderSize
        self.layer.masksToBounds = true
            
        // set up gradient
        let gradientLayer = CAGradientLayer()
            gradientLayer.frame = rect
        let c1 = bottomColor.colorWithAlphaComponent(bottomColorAlpha).CGColor
        let c2 = middleColor.colorWithAlphaComponent(middleColorAlpha).CGColor
        let c3 = topColor.colorWithAlphaComponent(topColorAlpha).CGColor
        gradientLayer.colors = [c3, c2, c1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradientLayer, atIndex: 0)
        
    }
}

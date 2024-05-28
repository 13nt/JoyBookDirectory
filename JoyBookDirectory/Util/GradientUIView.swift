//
//  GradientUIView.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 29/05/2024.
//

import UIKit

@IBDesignable
class GradientUIView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.blue {
        didSet {
            updateGradient()
        }
    }
    
    @IBInspectable var endColor: UIColor = UIColor.green {
        didSet {
            updateGradient()
        }
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    func updateGradient() {
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}

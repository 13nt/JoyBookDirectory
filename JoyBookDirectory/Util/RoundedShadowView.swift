//
//  RoundedShadowView.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

class RoundedShadowView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyRoundedShadow()
    }
    
    private func  applyRoundedShadow() {
//        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3
        layer.masksToBounds = false
    }
}

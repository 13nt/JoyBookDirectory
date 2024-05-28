//
//  TextFieldsClass.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

class SearchTextField: UITextField {
    
    var rightIcon :  UIView? {
        didSet {
            self.rightViewMode = .always
            self.rightView = rightIcon
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let btn = UIButton()
        btn.setImage(UIImage(named: "search")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageView?.tintColor = UIColor(named: "primary_color")
        self.rightIcon = btn
    }
    
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - bounds.height, y: 0, width: bounds.height, height: bounds.height)
    }
}

class SecureTextField: UITextField {
    
    private let eyesBtn : UIButton = UIButton()
    
    var rightIcon :  UIView? {
        didSet {
            self.rightViewMode = .always
            self.rightView = rightIcon
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let btn = UIButton()
        btn.setImage(UIImage(named: "password_hide")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageView?.tintColor = .gray
        btn.addTarget(self, action: #selector(self.toggle(sender:)), for: .touchDown)
        self.rightIcon = btn
    }
    
    @objc func toggle( sender : UIButton)  {
        self.isSecureTextEntry = !self.isSecureTextEntry
        if self.isSecureTextEntry {
            sender.setImage(UIImage(named: "password_hide")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }else {
            sender.setImage(UIImage(named: "password_show")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        sender.imageView?.tintColor = .gray
    }
    
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - bounds.height, y: 0, width: bounds.height, height: bounds.height)
    }
}

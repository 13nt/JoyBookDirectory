//
//  CustomProgressHUD.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

class CustomProgressHUD {
    
    private static var progressHUD: UIView?
    private static var overlayView: UIView?
    private static var activityIndicator: UIActivityIndicatorView?

    private init() {}
    
    class func show() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        overlayView = UIView(frame: window.bounds)
        overlayView?.backgroundColor = .black.withAlphaComponent(0.2)
        window.addSubview(overlayView!)
        
        progressHUD = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        progressHUD?.center = window.center
        progressHUD?.backgroundColor = UIColor.white
        progressHUD?.layer.cornerRadius = 10
        
        activityIndicator = UIActivityIndicatorView()
        
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .large)
        } else {
            // Fallback on earlier versions
        }
        activityIndicator?.color = UIColor(named: "primary_color")
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator?.startAnimating()
        
        progressHUD?.addSubview(activityIndicator!)
        window.addSubview(progressHUD!)
        
        activityIndicator?.centerXAnchor.constraint(equalTo: progressHUD!.centerXAnchor).isActive = true
        activityIndicator?.centerYAnchor.constraint(equalTo: progressHUD!.centerYAnchor).isActive = true
    }
    
    class func hide(completion: (() -> Void)? = nil) {
        activityIndicator?.stopAnimating() // Stop the animation
        
        UIView.animate(withDuration: 0.2, animations: {
            progressHUD?.alpha = 0.0
        }) { _ in
            activityIndicator?.removeFromSuperview()
            activityIndicator = nil
            
            progressHUD?.removeFromSuperview()
            progressHUD = nil
            
            overlayView?.removeFromSuperview()
            overlayView = nil
            
            completion?()
        }
    }
}

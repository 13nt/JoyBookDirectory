//
//  UIViewController.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func initiate(appStoryBoard: AppStoryboard) -> Self {
        return appStoryBoard.viewController(viewControllerClass: self)
    }
    
    func showMessageAlert(
        title: String,
        message: String,
        showCancel: Bool = false,
        showOK: Bool = false,
        okButtonTitle: String = "OK", // Default is "OK", will dissappear after triggered
        cancelHandler: (() -> Void)? = nil,
        okHandler: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        if showCancel {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                cancelHandler?()
            }
            alertController.addAction(cancelAction)
        }
        
        if showOK{
            let okAction = UIAlertAction(title: okButtonTitle, style: .default) { _ in
                okHandler?()
            }
            alertController.addAction(okAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showToastAlert(
        longSec: Double? = nil,
        title: String?,
        message: String?,
        alertStyle: UIAlertController.Style? = nil,
        sourceView: UIView? = nil,
        sourceRect: CGRect? = nil,
        barButtonItem: UIBarButtonItem? = nil,
        permittedArrowDirections: UIPopoverArrowDirection? = nil,
        completionHandler: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: alertStyle ?? .actionSheet
        )
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        
        let messageAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        let attributedTitle = NSAttributedString(string: title ?? "", attributes: titleAttributes)
        let attributedMessage = NSAttributedString(string: message ?? "", attributes: messageAttributes)
        
        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        alertController.setValue(attributedMessage, forKey: "attributedMessage")
        
        // Check if popover presentation is needed
        if alertController.preferredStyle == .actionSheet,
            let popoverController = alertController.popoverPresentationController {
            
            if let sourceView = sourceView {
                popoverController.sourceView = sourceView
            }
            
            if let sourceRect = sourceRect {
                popoverController.sourceRect = sourceRect
            }
            
            if let barButtonItem = barButtonItem {
                popoverController.barButtonItem = barButtonItem
            }
            
            if let permittedArrowDirections = permittedArrowDirections {
                popoverController.permittedArrowDirections = permittedArrowDirections
            }
        }
        
        present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + (longSec ?? 1)) {
                alertController.dismiss(animated: true) {
                    completionHandler?()
                }
            }
        }
    }
}

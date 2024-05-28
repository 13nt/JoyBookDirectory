//
//  AppStoryboard.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

enum AppStoryboard: String {
    
    case AuthEntry = "AuthEntry"
    case Main = "Main"
    case Search = "Search"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    // MARK: - Viewcontroller instantiate
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func navigateController<T: UINavigationController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UINavigationController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
}

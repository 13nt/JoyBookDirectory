//
//  BaseVC.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().tintColor = .primary
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    // MARK: Func for navigation and presenting controllers
    func navigateToViewController(_ viewController: UIViewController) {
        if self.navigationController != nil {
            self.navigationController?.pushViewController(viewController, animated: true)
        }else {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @objc func toRegisterVC(){
        let registerVC = AppStoryboard.AuthEntry.viewController(viewControllerClass: RegisterVC.self)
        registerVC.modalPresentationStyle = .fullScreen
        
        UIView.transition(with: UIApplication.shared.windows.first!,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
            UIApplication.shared.windows.first?.rootViewController = registerVC
        },
                          completion: nil)
    }
    
    @objc func toLoginInVC(){
        let signInVC = AppStoryboard.AuthEntry.viewController(viewControllerClass: LoginVC.self)
        signInVC.modalPresentationStyle = .fullScreen
        
        UIView.transition(with: UIApplication.shared.windows.first!,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
            UIApplication.shared.windows.first?.rootViewController = signInVC
        },
                          completion: nil)
    }
    
    @objc func toTabBarVC(){
        let tabBarVC = AppStoryboard.Main.viewController(viewControllerClass: BaseTabBarController.self)
        tabBarVC.modalPresentationStyle = .fullScreen
        
        UIView.transition(with: UIApplication.shared.windows.first!,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
            UIApplication.shared.windows.first?.rootViewController = tabBarVC
        },
                          completion: nil)
    }
    
    @objc func toSearchBookVC(){
        let searchBookVC = AppStoryboard.Search.viewController(viewControllerClass: SearchBookVC.self)
        searchBookVC.modalPresentationStyle = .fullScreen
        navigateToViewController(searchBookVC)
    }
    
    @objc func toBookDetailVC(bookID: String?){
        let bookDetailVC = AppStoryboard.Main.viewController(viewControllerClass: BookDetailVC.self)
        bookDetailVC.bookID = bookID
        bookDetailVC.modalPresentationStyle = .fullScreen
        navigateToViewController(bookDetailVC)
    }
    
    // MARK: Loading Handler
    func handleLoading(isLoading: Bool) {
        if isLoading {
            CustomProgressHUD.show()
        } else {
            CustomProgressHUD.hide()
        }
    }
    
}

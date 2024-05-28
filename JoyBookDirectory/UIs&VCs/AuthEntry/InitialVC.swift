//
//  InitialVC.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 29/05/2024.
//

import UIKit

class InitialVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            if LocalStorage.shared.isLoggedIn(){
                self?.toTabBarVC()
            }else{
                let loginVC = AppStoryboard.AuthEntry.viewController(viewControllerClass: LoginVC.self)
                self?.navigateToViewController(loginVC)
            }
        }
    }
}

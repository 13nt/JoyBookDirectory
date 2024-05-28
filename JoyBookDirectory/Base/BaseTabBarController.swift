//
//  BaseTabBarController.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
//        self.tabBar.tintColor = UIColor.white
        self.tabBar.tintColor = .white
        self.tabBar.barTintColor = .black
        self.tabBar.backgroundColor = .secondary
//        setupTabBar()
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let items = tabBar.items else { return }

        for (index, item) in items.enumerated() {
            let imageName: String
            switch index {
            case 0: imageName = "home"
            case 1: imageName = "training"
            default: return
            }

            let selectedImageName = imageName + "_select"
            let image = UIImage(named: (index == tabBarController.selectedIndex) ? selectedImageName : imageName)?.withRenderingMode(.alwaysOriginal)
            item.image = image
        }
    }

    private func createNavigationController(withStoryboardName name: String, viewControllerIdentifier identifier: String, title: String, imageName: String, tag: Int) -> UINavigationController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        controller.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        controller.tabBarItem.tag = tag
        return UINavigationController(rootViewController: controller)
    }

    private func setupTabBar() {
        let viewControllers: [UIViewController] = [
            createNavigationController(withStoryboardName: "Main", viewControllerIdentifier: "HomeVC", title: TabBarIndex.Home.rawValue, imageName: "home_select", tag: 0),
            createNavigationController(withStoryboardName: "Profile", viewControllerIdentifier: "ProfileVC", title: TabBarIndex.Profile.rawValue, imageName: "training", tag: 1)
        ]

        self.setViewControllers(viewControllers, animated: false)
        self.modalPresentationStyle = .fullScreen
    }

}

//
//  MainViewController.swift
//  Messenger
//
//  Created by Manmeet Singh on 23/12/24.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        setupTabBarViewControllers()
        setupUITabBarStyle()
    }
    
    // MARK: Private methods
    
    private func setupTabBarViewControllers() {
        let conversationViewController = createNavigationBarViewController(
            viewController: ConverstionsViewController(),
            title: "Chats",
            image: UIImage(systemName: "message"))
        
        let profileViewController = createNavigationBarViewController(
            viewController: ProfileViewController(),
            title: "Profile",
            image: UIImage(systemName: "person"))

        self.viewControllers = [conversationViewController, profileViewController]
    }
    
    private func setupUITabBarStyle() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .darkGray.withAlphaComponent(0.2)
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.boldSystemFont(ofSize: 12)
        ]
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 12)
        ]
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .gray
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .darkGray
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    private func createNavigationBarViewController(viewController: UIViewController,
                                                   title: String,
                                                   image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

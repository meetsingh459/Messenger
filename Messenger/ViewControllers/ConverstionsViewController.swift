//
//  ViewController.swift
//  Messenger
//
//  Created by Manmeet Singh on 22/12/24.
//

import UIKit

class ConverstionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isloggedIn")
        if !isLoggedIn {
            let viewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: false, completion: nil)
        }
    }

}


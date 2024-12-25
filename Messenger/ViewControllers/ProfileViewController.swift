//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Manmeet Singh on 22/12/24.
//

import UIKit
import FirebaseAuth
import FacebookLogin

class ProfileViewController: UIViewController {

    let tableView = UITableView()
    let data = ["Log out"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Profile"
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        setupTableView()
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = tableView.constraintsPinToParent(view: view)
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textColor = .red
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        FBSDKLoginKit.LoginManager().logOut()
        
        do {
            try FirebaseAuth.Auth.auth().signOut()
            let viewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: false, completion: nil)
        } catch {
            print("Error signing out: \(error)")
        }
    }
}


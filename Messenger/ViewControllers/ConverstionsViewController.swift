//
//  ViewController.swift
//  Messenger
//
//  Created by Manmeet Singh on 22/12/24.
//

import UIKit
import FirebaseAuth

class ConverstionsViewController: UIViewController {
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Chats"
        setupTableView()
        setupViews()
        setupNavigationBar()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let viewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: false, completion: nil)
        }
    }
    
    // MARK: Private helpers

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let constraints = tableView.constraintsPinToParent(view: view)
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newConversation))
    }
    
    @objc private func newConversation() {
        let viewController = UINavigationController(rootViewController: NewConversationViewController())
        present(viewController, animated: true)
    }
}


extension ConverstionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World!"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let chatViewController = ChatViewController()
        chatViewController.title = "Manmeet"
        chatViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
}

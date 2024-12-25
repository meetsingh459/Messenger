//
//  LoginViewController.swift
//  Messenger
//
//  Created by Manmeet Singh on 22/12/24.
//

import UIKit
import FacebookLogin
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class LoginViewController: UIViewController {
    
    // MARK: Private properties
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .black // Set the color of the spinner
        spinner.hidesWhenStopped = true // Automatically hide when stopped
        return spinner
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email address..."
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter password..."
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let facebookLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.permissions = ["public_profile", "email"]
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let googleSiginInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViewHierarchy()
        setupConstraints()
        setupInteraction()
    }
    
    // MARK: Private helpers
    
    private func setupNavigationBar() {
        title = "Log In"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Register",
            style: .done,
            target: self,
            action: #selector(didTapResigterButton))
    }
    
    private func setupViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(facebookLoginButton)
        scrollView.addSubview(googleSiginInButton)
        view.addSubview(spinner)
    }
    
    private func setupConstraints() {
        spinner.center = view.center
        let imageSize = view.width / 3
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            emailField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            emailField.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor),
            emailField.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor, multiplier: 0.8),
            emailField.heightAnchor.constraint(equalToConstant: 52),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10),
            passwordField.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor),
            passwordField.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor, multiplier: 0.8),
            passwordField.heightAnchor.constraint(equalToConstant: 52),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor, multiplier: 0.8),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            
            facebookLoginButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            facebookLoginButton.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor),
            facebookLoginButton.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor, multiplier: 0.8),
            facebookLoginButton.heightAnchor.constraint(equalToConstant: 52),
            
            googleSiginInButton.topAnchor.constraint(equalTo: facebookLoginButton.bottomAnchor, constant: 10),
            googleSiginInButton.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor),
            googleSiginInButton.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor, multiplier: 0.8),
            googleSiginInButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    private func setupInteraction() {
        emailField.delegate = self
        passwordField.delegate = self
        facebookLoginButton.delegate = self
        googleSiginInButton.addTarget(self, action: #selector (didTapGoogleLoginButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    
    private func invalidUserLoginAlert() {
        let alert = UIAlertController(
            title: "OOPs",
            message: "Please enter all the information correctly",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
    
    // MARK: Objective-C methods
    
    @objc private func didTapResigterButton() {
        navigationController?.pushViewController(ResigterViewController(), animated: true)
    }
    
    @objc private func didTapLoginButton() {
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty else {
            invalidUserLoginAlert()
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let result = authResult, error == nil else {
                print("Error to create user \(String(describing: error))")
                return
            }
            
            print("Loged in User \(result.user)")
            self?.navigationController?.dismiss(animated: true)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            loginButton.becomeFirstResponder()
        }
        
        return true
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        // no operation
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else {
            return
        }
        
        let request = FBSDKLoginKit.GraphRequest(
            graphPath: "me",
            parameters: ["fields": "email, first_name, last_name"],
            tokenString: token,
            version: nil,
            httpMethod: .get)
        
        spinner.startAnimating()
        request.start { _, result, error in
            guard let result, error == nil else {
                print("Failed to make facebook graphql request \(String(describing: error))")
                return
            }
            
            
            guard let data = result as? [String: Any],
                  let email = data["email"] as? String,
                  let firstName = data["first_name"] as? String,
                  let lastName = data["last_name"] as? String else {
                print("Facebook request failed to provide data.")
                return
            }
            
            let user = ChatAppUser(firstName: firstName, lastName: lastName, email: email)
            DatabaseManager.shared.validateUser(with: user.id) { exits in
                guard !exits else {
                    return
                }
                
                DatabaseManager.shared.createUser(user)
            }
        }
        
        let credidentials = FacebookAuthProvider.credential(withAccessToken: token)
        FirebaseAuth.Auth.auth().signIn(with: credidentials) { [weak self] authResult, error in
            self?.spinner.stopAnimating()
            guard authResult != nil, error == nil else {
                print("Unable to login via facebook \(String(describing: error))")
                return
            }
            
            print("Facebook login successful")
            self?.navigationController?.dismiss(animated: true)
        }
    }
}

extension LoginViewController {
    
    @objc func didTapGoogleLoginButton() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        spinner.startAnimating()

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            guard let user = result?.user, let token = user.idToken?.tokenString, error == nil else {
                print("Failed to login via google sign in")
                self?.spinner.stopAnimating()
                return
            }
            
            guard let email = user.profile?.email,
                  let firstName = user.profile?.givenName else {
                print("Google request failed to provide data.")
                self?.spinner.stopAnimating()
                return
            }
            
            let lastName = user.profile?.familyName ?? ""
            let chatUser = ChatAppUser(firstName: firstName, lastName: lastName, email: email)
            DatabaseManager.shared.validateUser(with: chatUser.id) { exits in
                guard !exits else {
                    return
                }
                
                DatabaseManager.shared.createUser(chatUser)
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: token,
                                                           accessToken: user.accessToken.tokenString)
            
            FirebaseAuth.Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                self?.spinner.stopAnimating()
                guard authResult != nil, error == nil else {
                    print("Unable to login via Google \(String(describing: error))")
                    return
                }
                
                print("Google login successfuls")
                self?.navigationController?.dismiss(animated: true)
            }
        }
    }
}

//
//  ViewController.swift
//  Bankey
//
//  Created by RuslanS on 7/9/22.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let appTitleLabel = UILabel()
    let appDescriptionLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension LoginViewController {
    private func style() {
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        appTitleLabel.textAlignment = .center
        appTitleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        appTitleLabel.adjustsFontForContentSizeCategory = true
        appTitleLabel.text = "Bankey"
        
        appDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        appDescriptionLabel.textAlignment = .center
        appDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        appDescriptionLabel.adjustsFontForContentSizeCategory = true
        appDescriptionLabel.numberOfLines = 0
        appDescriptionLabel.text = "Your premium source for all things banking!"
        
        loginView.translatesAutoresizingMaskIntoConstraints = false                 //Messes up all of the constraints if left turned on
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8                                // For indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center                                   //Text Alignment
        errorMessageLabel.textColor = .systemRed                                    //Text color
        errorMessageLabel.numberOfLines = 0                                         //No set amount of lines
        errorMessageLabel.isHidden = true                                           //Hides button until error
        
    }
    
    private func layout() {
        view.addSubview(appTitleLabel)
        view.addSubview(appDescriptionLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        //appTitle
        NSLayoutConstraint.activate([
            appDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: appTitleLabel.bottomAnchor, multiplier: 3),
            appTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //appDescription
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: appDescriptionLabel.bottomAnchor, multiplier: 3),
            appDescriptionLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            appDescriptionLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
            
        ])
        
        // LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        // Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),                //top of button = 2 below loginView
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),                                            //leading width = loginView lead width
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)                                           //trailing width = loginView trail width
        ])
        
        //errorLabel
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),        //top of label = 2 below signIn Button
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),                                       //leading width = signInButton lead width
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)                                      //trailing width = signInButton trail width
        ])
        
    }
}

// MARK: Actions
extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
//        if username.isEmpty || password.isEmpty {
//            configureView(withMessage: "Username / password cannot be blank")
//            return
//        }
        if username == "" && password == ""{
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}

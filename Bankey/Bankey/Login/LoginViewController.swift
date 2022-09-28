//
//  ViewController.swift
//  Bankey
//
//  Created by RuslanS on 7/9/22.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    //Creates the UIKit elements
    let appTitleLabel = UILabel()
    let appDescriptionLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text                         //Returns what the user wrote in username textfield
    }
    var password: String? {
        return loginView.passwordTextField.text                         //Returns what the user wrote in password textfield
    }
    
    //Animation
    var leadingEdgeOnScreen: CGFloat = 16                               //Onscreen leading edge constraint (used for animation)
    var leadingEdgeOffScreen: CGFloat = -1000                           //Offscreen leading edge constraint (used for animation)
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var descriptionLeadingAnchor: NSLayoutConstraint?

    override func viewDidLoad() {                                       //Executes when view appears (ie. app loads)
        super.viewDidLoad()
        style()                                                         //Sets up style
        layout()                                                        //Sets up layout
    }
    override func viewDidDisappear(_ animated: Bool) {                  //Executes when view dissapears (ie. next screen)
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
    override func viewDidAppear(_ animated: Bool) {                     //Executes when view appears (ie. app & view loads)
        super.viewDidAppear(animated)
        animate()                                                       //Calls function to animate elements
    }
}

extension LoginViewController {
    private func style() {
        
        //appTitleLabel setup/preferences
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        appTitleLabel.textAlignment = .center
        appTitleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        appTitleLabel.adjustsFontForContentSizeCategory = true
        appTitleLabel.text = "Bankey"
        appTitleLabel.alpha = 0
        
        //appDescriptionLabel setup
        appDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        appDescriptionLabel.textAlignment = .center
        appDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        appDescriptionLabel.adjustsFontForContentSizeCategory = true
        appDescriptionLabel.numberOfLines = 0
        appDescriptionLabel.text = "Your premium source for all things banking!"
        appDescriptionLabel.alpha = 0
        
        loginView.translatesAutoresizingMaskIntoConstraints = false                 //Messes up all of the constraints if left turned on
        
        //signInButton setup
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8                                // For indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        //errorMessageLabel setup
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center                                   //Text Alignment
        errorMessageLabel.textColor = .systemRed                                    //Text color
        errorMessageLabel.numberOfLines = 0                                         //No set amount of lines
        errorMessageLabel.isHidden = true                                           //Hides button until error
        
    }
    
    private func layout() {
        //Adds all the UIKit elements to the view
        view.addSubview(appTitleLabel)
        view.addSubview(appDescriptionLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        //appTitle
        NSLayoutConstraint.activate([
            appDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: appTitleLabel.bottomAnchor, multiplier: 3),
            appTitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        titleLeadingAnchor = appTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)                    //Sets initial position to leadingEdgeOffScreen
        titleLeadingAnchor?.isActive = true                                                                                                         //Activates the constraint (since not active array like above)
        
        //appDescription
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: appDescriptionLabel.bottomAnchor, multiplier: 3),
            appDescriptionLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        descriptionLeadingAnchor = appDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  leadingEdgeOffScreen)       //Sets initial position to leadingEdgeOffScreen
        descriptionLeadingAnchor?.isActive = true                                                                                                   //Activates the constraint (since not active array like above)
        
        //LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        //signInButton
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

//MARK: - Animations
extension LoginViewController {
    private func animate() {                                                                //Function that gets called when the view appears
        let duration = 0.5
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {     //Handles animation of the appTitle
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen                    //Sets leading edge of appTitleLabel animation
            self.view.layoutIfNeeded()                                                      //Notifies AutoLayout that we updated the values for layout
        }
        animator1.startAnimation()                                                          //Starts the animation
        
        let animator2 = UIViewPropertyAnimator(duration: duration*1.18, curve: .easeInOut) {
            self.descriptionLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.05)
        
        let animator3 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.appTitleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 0.05)
        
        let animator4 = UIViewPropertyAnimator(duration: duration*1.38, curve: .easeInOut) {
            self.appDescriptionLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator4.startAnimation(afterDelay: 0.05)
    }
}

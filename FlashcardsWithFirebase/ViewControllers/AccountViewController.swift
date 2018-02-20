//
//  LoginViewController.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseAuth
import SnapKit

class AccountViewController: UIViewController {
    
    let signIn = SignIn()
    let signUp = SignUp()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signIn)
        userChecker()
        buttonSetup()
        
    }
    
    private func userChecker() {
        if let _ = FirebaseManager.shared.getCurrentUser() {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: MainViewController())
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func buttonSetup() {
        //TODO: add forgot password
        signIn.loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        signIn.createAccount.addTarget(self, action: #selector(createPressed), for: .touchUpInside)
        signUp.signUpButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        signUp.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }
    
    @objc private func loginPressed() {
        //TODO: login check
        FirebaseManager.shared.login(withEmail: signIn.emailTextField.text!, andPassword: signIn.passwordTextField.text!) { (user, error) in
            if let error = error {
                print("login: \(error)")
            } else if let user = user {
                print("Logged In")
                let nav = UINavigationController(rootViewController: MainViewController())
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func createPressed() {
        self.view.addSubview(signUp)
    }
    
    @objc private func signUpPressed() {
        //TODO: error handling
        guard let nameText = signUp.nameTextField.text else {return}
        guard !nameText.isEmpty else {return}
        guard let emailText = signUp.emailTextField.text else {return}
        guard !emailText.isEmpty else {return}
        guard let passwordText = signUp.passwordTextField.text else {return}
        guard !passwordText.isEmpty else {return}
        guard let confirmText = signUp.confirmPasswordTextField.text else {return}
        guard !confirmText.isEmpty else {return}
        guard passwordText == confirmText else {
            showAlert(title: "Error", message: "Passwords don't match")
            return
        }
        FirebaseManager.shared.createAccount(email: emailText, password: passwordText, name: nameText) { (user, error) in
            if let error = error {
                print("createAccount: \(error)")
            }
        }
        showAlert(title: "Account Created", message: "An email has been sent for authorization")
        signUp.removeFromSuperview()
    }
    @objc private func backPressed() {
        self.signUp.removeFromSuperview()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == signIn {
                self.view.endEditing(true)
                self.resignFirstResponder()
                
            }
            if touch.view == signUp {
                self.view.endEditing(true)
                self.resignFirstResponder()
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
/// SignUp View
extension AccountViewController {
//    private func setupDelegates() {
//        signUp.emailTextField
//        signUp.nameTextField
//        signUp.passwordTextField
//    }
}


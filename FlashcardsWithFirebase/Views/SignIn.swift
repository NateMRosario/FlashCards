//
//  SignIn.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class SignIn: UIView {
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.lightGray.cgColor, UIColor(displayP3Red: 60/255, green: 78/255, blue: 102/255, alpha: 1)]
        return gradient
    }()
    
    lazy var flashCard: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "flashcard-icon")
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Settings.manager.globalTitleFont
        label.text = "FLASHCARDS"
        label.textColor = .lightGray
        return label
    }()
        
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = Settings.manager.globalDetailFont
        label.text = "------------- Log In -------------"
        label.textColor = .white
        return label
    }()

    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "  Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        tf.textColor = .white
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        // email icon
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = #imageLiteral(resourceName: "emailIcon")
        tf.leftView = imageView
        tf.leftViewMode = .always
        return tf
    }()
    lazy var emailLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "  Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        tf.textColor = .white
        tf.isSecureTextEntry = true
        // password icon
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = #imageLiteral(resourceName: "passwordIcon")
        tf.leftView = imageView
        tf.leftViewMode = .always
        return tf
    }()
    lazy var passwordLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var buttonBackground: UIView = {
        let view = UIView()
        let gradient = CAGradientLayer()
        let bottomColor = UIColor(red: 84/255.0, green: 180/255.0, blue: 225/255.0, alpha: 1).cgColor
        let topColor = UIColor(red: 100/255.0, green: 190/255.0, blue: 180/255.0, alpha: 1).cgColor
        let gradientColors = [topColor, bottomColor]
        let gradientLocations: [NSNumber] = [0.0, 1.0]
        gradient.colors = gradientColors
        gradient.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        gradient.locations = gradientLocations
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.cornerRadius = 4.0
        gradient.masksToBounds = true
        view.layer.insertSublayer(gradient, at: 0)
        return view
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOG IN", for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var forgotPassword: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        return button
    }()
    
    lazy var createAccount: UIButton = {
        let button = UIButton()
        button.setTitle("Don't have an account?", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = Settings.manager.globalColor
        layer.addSublayer(gradientLayer)
        addSubview(flashCard)
        addSubview(buttonBackground)
        addSubview(emailLine)
        addSubview(passwordLine)
        setupViews()
    }
    private func setupViews() {
        let viewObjects = [titleLabel, detailLabel, emailTextField, passwordTextField, forgotPassword, loginButton, createAccount] as! [UIView]
        viewObjects.forEach{addSubview($0); $0.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self)
        })}
        let padding = 20
        
        flashCard.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(padding)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(flashCard.snp.bottom).offset(padding)
            make.height.equalTo(padding + 20)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(padding)
            make.height.equalTo(padding + 10)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(padding)
            make.width.equalTo(self).multipliedBy(0.8)
        }
        emailLine.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(1)
            make.centerX.equalTo(self)
            make.width.equalTo(emailTextField)
            make.height.equalTo(1)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(padding)
            make.width.equalTo(emailTextField)
        }
        passwordLine.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(1)
            make.centerX.equalTo(self)
            make.width.equalTo(passwordTextField)
            make.height.equalTo(1)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(padding)
            make.width.equalTo(emailTextField)
        }
        buttonBackground.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(passwordTextField.snp.bottom).offset(padding)
            make.width.height.equalTo(loginButton)
        }
        
        forgotPassword.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(padding)
        }
        
        createAccount.snp.makeConstraints { (make) in
            make.top.equalTo(forgotPassword.snp.bottom).offset(padding)
        }
    }
}

//
//  LoginView.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit

class SignUp: UIView {
    
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
        label.text = "------------- Registration -------------"
        label.textColor = .white
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        tf.textColor = .white
        return tf
    }()
    lazy var nameLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        tf.textColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        return tf
    }()
    lazy var emailLine : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        tf.textColor = .white
        tf.isSecureTextEntry = true
        return tf
    }()
    let passwordLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        tf.textColor = .white
        tf.isSecureTextEntry = true
        return tf
    }()
    let confirmLine: UIView = {
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
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN UP", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Already have an account?", for: .normal)
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
        addSubview(flashCard)
        addSubview(buttonBackground)
        addSubview(nameLine)
        addSubview(emailLine)
        addSubview(passwordLine)
        addSubview(confirmLine)
        setupViews()
    }
    private func setupViews() {
        let viewObjects = [titleLabel, detailLabel, nameTextField, emailTextField, passwordTextField, confirmPasswordTextField, signUpButton, backButton] as [UIView]
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
        
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(padding)
            make.width.equalTo(self).multipliedBy(0.8)
        }
        nameLine.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(1)
            make.centerX.equalTo(self)
            make.width.equalTo(nameTextField)
            make.height.equalTo(1)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(padding)
            make.width.equalTo(nameTextField)
        }
        emailLine.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(1)
            make.centerX.equalTo(self)
            make.width.equalTo(nameTextField)
            make.height.equalTo(1)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(padding)
            make.width.equalTo(nameTextField)
        }
        passwordLine.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(1)
            make.centerX.equalTo(self)
            make.width.equalTo(nameTextField)
            make.height.equalTo(1)
        }
        
        confirmPasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(padding)
            make.width.equalTo(nameTextField)
        }
        confirmLine.snp.makeConstraints { (make) in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(1)
            make.centerX.equalTo(self)
            make.width.equalTo(nameTextField)
            make.height.equalTo(1)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(padding)
            make.width.equalTo(nameTextField)
        }
        
        buttonBackground.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(padding)
            make.width.height.equalTo(signUpButton)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(signUpButton.snp.bottom).offset(padding)
            make.width.equalTo(nameTextField)
        }
        
    }
    
}

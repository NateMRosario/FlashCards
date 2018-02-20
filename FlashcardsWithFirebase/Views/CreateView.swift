//
//  CreateView.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CreateView: UIView {
    
    var blurView: UIVisualEffectView = {
        var blurEffect = UIBlurEffect()
        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.opacity = 0.65
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Settings.manager.globalColor
        view.layer.cornerRadius = 20
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "CATEGORY"
        label.textColor = UIColor(red: 84/255.0, green: 180/255.0, blue: 225/255.0, alpha: 1)
        return label
    }()
    
    lazy var categoryTextField: UITextField = {
        let tf = UITextField()
        tf.spellCheckingType = .no
        let centered = NSMutableParagraphStyle()
        centered.alignment = .center
        var attributes = NSMutableAttributedString()
        let name = "Enter a name"
        attributes = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray])
        attributes.addAttributes([NSAttributedStringKey.paragraphStyle: centered], range: NSRange(location: 0, length: name.count))
        tf.attributedPlaceholder = attributes
        tf.textAlignment = .center
        tf.textColor = .white
        return tf
    }()
    lazy var categoryLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor(red: 84/255.0, green: 180/255.0, blue: 225/255.0, alpha: 1), for: .normal)
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
        backgroundColor = .clear
        setupViews()
    }
    private func setupViews() {
        blurView.frame = bounds
        let viewObjects = [blurView, containerView, categoryLine, titleLabel, categoryTextField, doneButton] as [UIView]
        viewObjects.forEach{addSubview($0)}
        
        containerView.snp.makeConstraints { (view) in
            view.center.equalTo(self)
            view.width.equalTo(self).multipliedBy(0.7)
            view.height.equalTo(self).multipliedBy(0.25)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(30)
            make.centerX.equalTo(containerView)
        }
        categoryTextField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.width.equalTo(containerView).multipliedBy(0.8)
            make.centerX.equalTo(containerView)
        }
        categoryLine.snp.makeConstraints { (make) in
            make.top.equalTo(categoryTextField.snp.bottom).offset(1)
            make.centerX.equalTo(containerView)
            make.width.equalTo(categoryTextField).multipliedBy(0.7)
            make.height.equalTo(1)
        }
        doneButton.snp.makeConstraints { (make) in
            make.top.equalTo(categoryTextField.snp.bottom).offset(20)
            make.width.equalTo(categoryTextField)
            make.centerX.equalTo(containerView)
        }
    }
}

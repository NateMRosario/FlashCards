//
//  FlashCardView.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FlashCardView: UIView {
    
    lazy var categoryName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Settings.manager.globalTitleFont
        label.text = " "
        label.textColor = .lightGray
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "1/10"
        label.textColor = .white
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 20
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        return view
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Settings.manager.globalTitleFont
        label.text = "What is a TableView?"
        return label
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
        setupViews()
    }
    private func setupViews() {
        addSubview(categoryName)
        addSubview(countLabel)
        addSubview(containerView)
        addSubview(questionLabel)
        
        categoryName.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(40)
        }
        
        countLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-50)
            make.bottom.equalTo(containerView.snp.top).offset(-10)
        }
        containerView.snp.makeConstraints { (view) in
            view.center.equalTo(self)
            view.width.equalTo(self).multipliedBy(0.85)
            view.height.equalTo(self).multipliedBy(0.45)
        }
        questionLabel.snp.makeConstraints { (make) in
            make.center.equalTo(containerView)
        }
    }
}

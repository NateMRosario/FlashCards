//
//  FlashCardOptionView.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FlashCardOptionView: UIView {

    lazy var categoryName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Settings.manager.globalTitleFont
        label.text = " "
        label.textColor = .lightGray
        return label
    }()
    lazy var cardCount: UILabel = {
        let label = UILabel()
        //TODO: add card count
        label.text = "Card Count: 2"
        label.textColor = .lightGray
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Testing", for: .normal)
        return button
    }()
    
    lazy var addCardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create a new card", for: .normal)
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
        setupViews()
    }
    private func setupViews() {
        addSubview(categoryName)
        addSubview(startButton)
        addSubview(cardCount)
        addSubview(addCardButton)
        let padding = 40
        
        categoryName.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(padding)
        }
        cardCount.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(categoryName.snp.bottom).offset(padding + 20)
        }
        
        startButton.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        addCardButton.snp.makeConstraints { (make) in
            make.top.equalTo(startButton.snp.bottom).offset(padding)
            make.centerX.equalTo(self)
        }
    }

}

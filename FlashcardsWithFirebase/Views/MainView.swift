//
//  MainView.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    lazy var title = Settings.manager.appName
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        // TODO: Set name
        label.font = Settings.manager.globalDetailFont
        label.text = " "
        label.textColor = .lightGray
        return label
    }()
    
    lazy var addCategoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Category", for: .normal)
        button.setTitleColor(UIColor(red: 84/255.0, green: 180/255.0, blue: 225/255.0, alpha: 1), for: .normal)
        button.titleLabel?.font = Settings.manager.globalDetailFont
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.cornerRadius = 2
        button.backgroundColor = Settings.manager.globalColor
        return button
    }()
    lazy var buttonBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = UIColor(displayP3Red: 80/255, green: 98/255, blue: 122/255, alpha: 1)
        return view
    }()
    
    lazy var categoryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "CategoryCell")
        cv.layer.cornerRadius = 2
        cv.backgroundColor = UIColor(displayP3Red: 80/255, green: 98/255, blue: 122/255, alpha: 1)
        return cv
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
        addSubview(welcomeLabel)
        addSubview(categoryCollection)
        addSubview(title)
        addSubview(buttonBackground)
        addSubview(addCategoryButton)
        let padding = 20
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(padding + 20)
            make.centerX.equalTo(self)
        }
        welcomeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(padding)
            make.centerX.equalTo(self)
        }
        
        buttonBackground.snp.makeConstraints { (view) in
            view.centerX.equalTo(self)
            view.bottom.equalTo(categoryCollection.snp.top).offset(-padding + 10)
            view.height.equalTo(padding + 24)
            view.width.equalTo(categoryCollection)
        }
        addCategoryButton.snp.makeConstraints { (make) in
            make.center.equalTo(buttonBackground)
            make.height.equalTo(buttonBackground).multipliedBy(0.7)
            make.width.equalTo(buttonBackground).multipliedBy(0.96)
        }
        
        
        categoryCollection.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(padding)
            make.trailing.bottom.equalTo(self).offset(-padding)
            make.height.equalTo(self).multipliedBy(0.5)
        }
        
    }

}

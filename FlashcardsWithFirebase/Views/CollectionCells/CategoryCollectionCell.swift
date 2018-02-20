//
//  CategoryCollectionCell.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    
    lazy var categoryName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 84/255.0, green: 180/255.0, blue: 225/255.0, alpha: 1)
        label.font = Settings.manager.globalDetailFont
        label.adjustsFontSizeToFitWidth = true
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
        backgroundColor = .white
        setupViews()
    }
    private func setupViews() {
        addSubview(categoryName)
        
        categoryName.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(self)
        }
    }
}

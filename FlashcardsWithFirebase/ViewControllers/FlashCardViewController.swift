//
//  FlashCardViewController.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FlashCardViewController: UIViewController {
    
    var category: CardCategory!
    
    let flashView = FlashCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(flashView)
        flashView.categoryName.text = category.name
        constrainView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCard))
    }
    private func constrainView() {
        flashView.snp.makeConstraints { (view) in
            view.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func addCard() {
    }


}

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
    
    let flashView = FlashCardOptionView()
    let flahCards = FlashCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(flashView)
        flashView.categoryName.text = category.name
        constrainView()
        flashView.startButton.addTarget(self, action: #selector(startPressed), for: .touchUpInside)
        flashView.addCardButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
    }
    private func constrainView() {
        flashView.snp.makeConstraints { (view) in
            view.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func startPressed() {
        self.view.addSubview(flahCards)
    }
    @objc private func addPressed() {
        //TODO: add cards
    }
    


}

//
//  QuestionAnswerViewController.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class QuestionAnswerViewController: UIViewController {
    
    let flashCards = FlashCardView()
    var cards = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(flashCards)
        flashCards.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        flashCards.countLabel.text = "\(cards.count)"
    }
    @objc private func backPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //TODO: Load cards
    private func loadCard() {
        flashCards.questionLabel.text = cards[0].question
    }
}

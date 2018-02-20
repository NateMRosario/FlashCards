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
    var cards = [Card]() {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    
    let flashView = FlashCardOptionView()
    let flashCards = QuestionAnswerViewController()

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
        self.flashCards.cards = cards
        self.present(flashCards, animated: true, completion: nil)
    }
    @objc private func addPressed() {
        //TODO: add cards
        showAlert(title: "Question and Answer", message: "")
        FirebaseManager.shared.loadCards { (card, error) in
            if let error = error {
                print(error)
            } else if let card = card {
                self.cards = card
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter a Question"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter the Answer"
        }
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak alertController](_) in
            let question = alertController?.textFields![0].text
            let answer = alertController?.textFields![1].text
            FirebaseManager.shared.addCard(question: question!, answer: answer!, category: self.category)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }


}

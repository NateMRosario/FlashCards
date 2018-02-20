//
//  CreateViewController.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    let createView = CreateView()
    var user: CurrentUser!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createView)
        doneButton()
    }
    
     func doneButton() {
        createView.doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
    }
    
    @objc func doneButtonPressed() {
        guard let text = createView.categoryTextField.text else {return}
        guard !text.isEmpty else {return}
        FirebaseManager.shared.addCategory(name: text, userUID: self.user.userUID!, errorHandler: {print($0)})
        
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == createView.containerView {
                self.view.endEditing(true)
                self.resignFirstResponder()
            }
            if touch.view == createView.blurView {
                dismiss(animated: true, completion: nil)
            } else {
                return
            }
        }
    }


}

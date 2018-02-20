//
//  Settings.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit

class Settings {
    private init() {}
    static let manager = Settings()
    
    let globalColor = UIColor(displayP3Red: 60/255, green: 78/255, blue: 102/255, alpha: 1)
    let globalDetailFont = UIFont(name: "Georgia", size: 18)
    let globalTitleFont = UIFont(name: "Georgia", size: 30)

    lazy var appName: UILabel = {
        let label = UILabel()
        label.font = globalTitleFont
        label.text = "FLASHCARDS"
        label.textColor = .lightGray
        return label
    }()
}

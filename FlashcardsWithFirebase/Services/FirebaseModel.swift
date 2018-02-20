//
//  FirebaseModel.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/14/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

typealias categoryUID = String
typealias cardUID = String
typealias userUID = String

struct CurrentUser: Codable {
    let name: String?
    let userUID: String?
    let categories: [categoryUID]?
    func userToJson() -> Any {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
}
struct CardCategory: Codable {
    let name: String?
    let userUID: userUID
    let categoryUID: categoryUID
    let cards: [cardUID]?
    func cardToJson() -> Any {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
}
struct Card: Codable {
    let question: String?
    let answer: String?
    let cardUID: cardUID
    func questionToJson() -> Any {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
}


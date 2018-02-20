//
//  FirebaseManager.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/14/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

enum Problems: Error {
    case emptyCardArrayInCategory
    case userHasNoCategory
    case noUserSignedIn
    case emptyCardArrayInCategory
}

class FirebaseManager {
    static let shared = FirebaseManager()
    private init() {
        dataBaseRef = Database.database().reference()
        usersReference = dataBaseRef.child("users")
        categoryReference = dataBaseRef.child("category")
        cardReference = dataBaseRef.child("card")
    }
    private var dataBaseRef: DatabaseReference!
    private var usersReference: DatabaseReference!
    private var categoryReference: DatabaseReference!
    private var cardReference: DatabaseReference!
    
    /// User functions
    public func getCurrentUser() -> User? {
        if Auth.auth().currentUser != nil {
            return Auth.auth().currentUser
        }
        return nil
    }
    
    public func getUserFrom(uid: String, completionHandler: @escaping (CurrentUser) -> Void, errorHandler: @escaping (Error) -> Void) {
        usersReference.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let json = snapshot.value {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    let user = try JSONDecoder().decode(CurrentUser.self, from: jsonData)
                    completionHandler(user)
                } catch {
                    errorHandler(error)
                }
            }
        }
    }
    public func login(withEmail email: String, andPassword password: String, completionHandler: @escaping (User?, Error?) -> Void) {
        let completion: (User?, Error?) -> Void = { (user, error) in
            if let error = error {
                completionHandler(nil, error)
            } else if let user = user {
                completionHandler(user, nil)
            }
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    public func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    public func createAccount(email: String, password: String, name: String, completionHandler: @escaping (User?, Error?) -> Void) {
        let completion: (User?, Error?) -> Void = { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let user = user {
                let child = self.usersReference.child(user.uid)
                child.setValue(CurrentUser(name: name, userUID: user.uid, categories: nil).userToJson())
                
                ///Send verification email
                                    user.sendEmailVerification(completion: { (error) in
                                        if let error = error {
                                            print(error)
                                        } else {
                                            print("verification email sent")
                                        }
                                    })
            }
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    public func forgotPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    public func getUsernameFromUID(uid: String, completionHandler: @escaping (String) -> Void, errorHandler: @escaping (Error) -> Void) {
        usersReference.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let json = snapshot.value {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    let user = try JSONDecoder().decode(CurrentUser.self, from: jsonData)
                    completionHandler(user.name!)
                } catch {
                    errorHandler(error)
                }
            }
        }
    }
    
    //    func changeUsernameFrom(userUID: String, newUsername: String) {
    //        Database.database().reference(withPath: "users").child(userUID).child("appUserName").setValue(newUsername)
    //    }
}
extension FirebaseManager {
    /// Category functions
    
    public func addCategory(name: String, userUID: String, errorHandler: @escaping(Error) -> Void) {
        guard let currentUser = getCurrentUser() else {
            errorHandler(Problems.noUserSignedIn)
            return
        }
        let child = categoryReference.childByAutoId()
        let childKey = child.key
        child.setValue(CardCategory(name: name, userUID: userUID, categoryUID: child.key, cards: nil).cardToJson())
        // get userUID
        let userChild = usersReference.child(currentUser.uid)
        loadUserCategoryUIDs(userUID: currentUser.uid, completionHandler: { (UIDArrays) in
            var myUIDS = UIDArrays
            myUIDS.append(childKey)
            userChild.child("categories").setValue(myUIDS)
        }) { (error) in
            errorHandler(Problems.userHasNoCategory)
            print("cool")
            userChild.child("categories").setValue([childKey])
        }
    }
    // this funciton will load the user's category UIDS
    private func loadUserCategoryUIDs(userUID: String, completionHandler: @escaping ([String]) -> Void, errorHandler: @escaping (Error) -> Void) {
        usersReference.child(userUID).child("categories").observeSingleEvent(of: .value, with: { (snapshot) in
            if let uids = snapshot.value as? [String] {
                completionHandler(uids)
            } else {
                errorHandler(Problems.emptyCardArrayInCategory)
            }
        })
    }
    
    //this function will load the category of a user
    func loadCategory(user: CurrentUser, completionHandler: @escaping ([CardCategory]) -> Void, errorHandler: @escaping (Error) -> Void) {
        // loop through array to get category
        guard let categoryUIDS = user.categories else {
            errorHandler(Problems.userHasNoCategory)
            return
        }
        var categories = [CardCategory]() {
            didSet {
                completionHandler(categories)
            }
        }
        for categoryUID in categoryUIDS {
            DispatchQueue.main.async {
                self.getCategory(from: categoryUID, completion: {categories.append($0)}, errorHandler: {print($0)})
            }
        }
    }
    
    // this function will get a category from categoryUID
    private func getCategory(from categoryUID: String, completion: @escaping (CardCategory) -> Void, errorHandler: @escaping (Error) -> Void) {
        categoryReference.child(categoryUID).observeSingleEvent(of: .value) { (snapshot) in
            if let json = snapshot.value {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    let category = try JSONDecoder().decode(CardCategory.self, from: jsonData)
                    completion(category)
                } catch {
                    errorHandler(error)
                }
            }
        }
    }
    
    func deleteCategory(category: CardCategory) {
        deleteCategoryFromUser(userUID: category.userUID, categoryUIDToDelete: category.categoryUID) { (error) in
            print(error)
        }
        categoryReference.child(category.categoryUID).removeValue()
    }
    
    private func deleteCategoryFromUser(userUID: String, categoryUIDToDelete: String, errorHandler: @escaping (Error) -> Void) {
        loadUserCategoryUIDs(userUID: userUID, completionHandler: { (categoryUIDS) in
            if categoryUIDS.count <= 1 {
                self.usersReference.child(userUID).child("category").removeValue()
            } else {
                let newUIDS = categoryUIDS.filter{$0 != categoryUIDToDelete}
                self.usersReference.child(userUID).child("category").setValue(newUIDS)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}
extension FirebaseManager {
    /// FlashCard Functions
    func addCard(question: String, answer: String, category: CardCategory) {
        let child = cardReference.childByAutoId()
        
        let card = Card(question: question, answer: answer, cardUID: child.key).questionToJson()
        let categoryChild = getCategoryChild(uid: category.categoryUID)
        
        loadCommentUIDs(categoryUID: category.categoryUID, completionHandler: {
            var currentUIDS = $0
            currentUIDS.append(child.key)
            categoryChild.child("cards").setValue(currentUIDS)
        }, errorHandler: {
            print($0)
            categoryChild.child("cards").setValue([child.key])
        })
        
    }
    private func getCategoryChild(uid: String) -> DatabaseReference {
        return Database.database().reference(withPath: "categories").child(uid)
    }
    private func loadCommentUIDs(categoryUID: String,
                         completionHandler: @escaping ([String]) -> Void,
                         errorHandler: @escaping (Error) -> Void) {
        categoryReference.child("cards").observeSingleEvent(of: .value) { (snapshot) in
            if let uids = snapshot.value as? [String] {
                completionHandler(uids)
            } else {
                errorHandler(Problems.emptyCardArrayInCategory
            }
        })
    }
}


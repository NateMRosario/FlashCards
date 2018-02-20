//
//  ViewController.swift
//  FlashcardsWithFirebase
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let cellSpacing: CGFloat = UIScreen.main.bounds.width * 0.025

    var categories = [CardCategory]() {
        didSet {
            self.mainView.categoryCollection.reloadData()
        }
    }
    var currentUser: CurrentUser! {
        didSet {
            print("1")
            if let name = currentUser.name {
            mainView.welcomeLabel.text = "Welcome \(name)"
            }
            self.loadUserCategory()
        }
    }
    var selectedCategory: CardCategory?
    let mainView = MainView()
    let createCategory = CreateViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        mainView.categoryCollection.delegate = self
        mainView.categoryCollection.dataSource = self
        addCategoryButton()
        configureNav()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadObjects()
    }
    private func loadUserCategory() {
        guard let user = currentUser else {return}
        FirebaseManager.shared.loadCategory(user: user, completionHandler: {self.categories = $0}, errorHandler: {print($0)})
    }
    
    private func loadObjects() {
        FirebaseManager.shared.getUserFrom(uid: FirebaseManager.shared.getCurrentUser()!.uid, completionHandler: {self.currentUser = $0}, errorHandler: {print($0)})
    }
    private func configureNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutPressed))
        let logo = #imageLiteral(resourceName: "flashcard-icon")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    @objc private func logoutPressed() {
        FirebaseManager.shared.logOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func addCategoryButton() {
        mainView.addCategoryButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    @objc private func addButtonPressed() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
            self.mainView.addCategoryButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9) }, completion: { finished in
                UIView.animate(withDuration: 0.06, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseIn, animations: { self.mainView.addCategoryButton.transform = CGAffineTransform(scaleX: 1, y: 1) }, completion: {(_) in
                    self.showAlert()
//                    self.createCategory.user = self.currentUser
//                    self.createCategory.modalTransitionStyle = .crossDissolve
//                    self.createCategory.modalPresentationStyle = .overCurrentContext
//                    self.present(self.createCategory, animated: true, completion: nil)
                } )})
        
    }
    ///Delete
    func showAlert() {
        let alert = UIAlertController(title: "Category", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Category Name"
        }
        alert.addAction(UIAlertAction(title: "Done", style: .default) { [weak alert](_) in
            // TODO: set category on firebase
            let text = alert?.textFields![0].text
            FirebaseManager.shared.addCategory(name: text! , userUID: self.currentUser.userUID!, errorHandler: {print($0)})
//            self.loadUserCategory()
            self.loadObjects()
            self.mainView.categoryCollection.reloadData()
            print("2")
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionCell
        let category = categories[indexPath.row]
        self.selectedCategory = category
        cell.backgroundColor = Settings.manager.globalColor
        cell.layer.shadowOpacity = 0.8
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.categoryName.text = category.name
        let holdGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPressed))
        cell.addGestureRecognizer(holdGesture)
        return cell
    }
    
    @objc private func cellLongPressed() {
        holdAlert(category: selectedCategory!)
    }
    private func holdAlert(category: CardCategory) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            print("Deleted")
            //TODO: Finish Delete Function
            FirebaseManager.shared.deleteCategory(category: category)
            self.mainView.categoryCollection.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let category = categories[indexPath.row]
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
            cell?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9) }, completion: { finished in
                UIView.animate(withDuration: 0.06, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseIn, animations: { cell?.transform = CGAffineTransform(scaleX: 1, y: 1) }, completion: {(_) in
                    let flashcardVC = FlashCardViewController()
                    flashcardVC.category = category
                    self.navigationController?.pushViewController(flashcardVC, animated: true)
                } )})
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 2
        let numSpaces: CGFloat = numCells + 1
        
        let width = (collectionView.bounds.width - (numSpaces * cellSpacing)) / numCells
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}

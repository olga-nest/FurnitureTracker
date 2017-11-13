//
//  DetailViewController.swift
//  FurnitureTracker
//
//  Created by Olga on 11/11/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UITableViewController {
    
    var furnitureArr = [Any]()
    let realm = try! Realm()
    var room: Room!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFurniture(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        navigationItem.title = room.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        updateRealmResults()
    }
    
    
    @objc func addFurniture(_ sender: Any){
        
        let alert = UIAlertController(title: "Add a piece of furniture ",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addTextField {(textField : UITextField!) -> Void in
            textField.placeholder = "Enter Name"
        }
        let okAction = UIAlertAction(title: "Save", style: .default) {
            (action: UIAlertAction) in
            
            if  let alertTextField = alert.textFields?.first, alertTextField.text != nil {
                let furniture = Furniture()
                furniture.name = alertTextField.text!
                furniture.room = self.room
                
                try! self.realm.write {
                    self.realm.add(furniture)
                    self.updateRealmResults()
                }
                
                self.tableView.reloadData()
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    func updateRealmResults() {
        let results = realm.objects(Furniture.self).filter("room = %@", self.room)
        furnitureArr = Array(results)
    }
    
    //MARK: Table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return furnitureArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fCell", for: indexPath)
        
        let furniture = furnitureArr[indexPath.row] as! Furniture
        cell.textLabel!.text = furniture.name
        return cell
    }

}

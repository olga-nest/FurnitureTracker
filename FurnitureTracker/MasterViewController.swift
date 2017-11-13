//
//  MasterViewController.swift
//  FurnitureTracker
//
//  Created by Olga on 11/11/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

import UIKit
import RealmSwift

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    let realm = try! Realm()


    override func viewDidLoad() {
        super.viewDidLoad()
        updateRealmResults()
        
   //     navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRoom(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        updateRealmResults()
    }

    @objc
    func addRoom(_ sender: Any) {
        let alert = UIAlertController(title: "Add new room",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addTextField {(textField : UITextField!) -> Void in
            textField.placeholder = "Enter Room Name"
        }
        let okAction = UIAlertAction(title: "Save", style: .default) {
            (action: UIAlertAction) in
            
            if  let alertTextField = alert.textFields?.first, alertTextField.text != nil {
                let room = Room()
                room.name = alertTextField.text!
                
                try! self.realm.write {
                    self.realm.add(room)
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

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let controller = segue.destination as! UINavigationController
                let detailVC = controller.topViewController as! DetailViewController
                
                let room = objects[indexPath.row]
                detailVC.room = room as! Room
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let room = objects[indexPath.row] as! Room
        cell.textLabel!.text = room.name
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    func updateRealmResults() {
        let results = realm.objects(Room.self)
        objects = Array(results)
    }


}


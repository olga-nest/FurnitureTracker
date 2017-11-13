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
        //  updateRealmResults(@objc )
    }
    
    
    @objc func addFurniture(_ sender: Any){
    }

}

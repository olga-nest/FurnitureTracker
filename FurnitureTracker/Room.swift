//
//  Room.swift
//  FurnitureTracker
//
//  Created by Olga on 11/12/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

import Foundation
import RealmSwift

class Room: Object {
    @objc dynamic var name = ""
    
    let furniture = LinkingObjects(fromType: Furniture.self, property: "room")
}

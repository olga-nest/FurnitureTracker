//
//  Furniture.swift
//  FurnitureTracker
//
//  Created by Olga on 11/12/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

import Foundation
import RealmSwift

class Furniture: Object {
    @objc dynamic var name = ""
    @objc dynamic var room: Room!
}

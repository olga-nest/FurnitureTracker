//
//  Furniture.swift
//  FurnitureTracker
//
//  Created by Olga on 11/12/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

import Foundation
import Realm

class Furniture: RLMObject {
    @objc dynamic var name = ""
    @objc dynamic var room: Room!
}

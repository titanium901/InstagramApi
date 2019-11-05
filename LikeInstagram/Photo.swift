//
//  User.swift
//  LikeInstagram
//
//  Created by Iury Popov on 02.11.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation
import RealmSwift

class Photo: Object {
    @objc dynamic var id = 0
    @objc dynamic var data: NSData?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

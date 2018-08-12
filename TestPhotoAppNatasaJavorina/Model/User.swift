//
//  User.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/12/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import Foundation

class User {
    
    var userId: Int
    var name: String
    var username: String
    var website: String
    var albums: [Album]?
    var photos: [Photo]?
    
    init(dict: JSON) {
        userId = dict["id"] as! Int
        name = dict["name"] as! String
        username = dict["username"] as! String
        website = dict["website"] as! String
        
        
    }
}

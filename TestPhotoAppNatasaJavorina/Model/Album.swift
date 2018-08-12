//
//  Album.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/12/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import Foundation

class Album {
    var userId: Int
    var albumId: Int
    var title: String
    var photos: [Photo]?
    
    init(dict: JSON) {
        
        userId = dict["userId"] as! Int
        albumId = dict["id"] as! Int
        title = dict["title"] as! String
    }
}

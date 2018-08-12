//
//  Photo.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/12/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

class Photo {
    var albumId: Int
    var photoId: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
    init(dict: JSON) {
        albumId = dict["albumId"] as! Int
        photoId = dict["id"] as! Int
        title = dict["title"] as! String
        url = dict["url"] as! String
        thumbnailUrl = dict["thumbnailUrl"] as! String
        
    }
}

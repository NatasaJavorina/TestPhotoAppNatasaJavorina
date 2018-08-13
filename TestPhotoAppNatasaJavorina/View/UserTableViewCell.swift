//
//  UserTableViewCell.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/13/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit
import MDHTMLLabel

class UserTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var websiteLabel: MDHTMLLabel!



    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

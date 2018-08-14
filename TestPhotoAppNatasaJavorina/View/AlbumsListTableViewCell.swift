//
//  AlbumsListTableViewCell.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/12/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit

class AlbumsListTableViewCell: UITableViewCell {
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var thumbImage: UIImageView!
    @IBOutlet var basicView: UIView!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        basicView.backgroundColor = UIColor.white
        
        let shadowPath = UIBezierPath(rect: self.basicView.bounds)
        basicView.layer.masksToBounds = false
        basicView.layer.shadowColor = UIColor.black.cgColor
        basicView.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        basicView.layer.shadowOpacity = 1
        basicView.layer.shadowPath = shadowPath.cgPath
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

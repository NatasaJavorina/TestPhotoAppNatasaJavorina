//
//  SinglePhotoViewController.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/12/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit
import SDWebImage

class SinglePhotoViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitState()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func setInitState() {
        
        
        let imageURL = photo?.url
        mainImage.sd_setImage(with: URL(string: imageURL!), placeholderImage: UIImage(named: "placeholder.png"))
        
    }
  

}

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
  
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func saveImageButtonTapped(_ sender: UIButton) {
        
         UIImageWriteToSavedPhotosAlbum(mainImage.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    
}

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
    @IBOutlet var photoTitle: UILabel!
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitState()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Functions

    
    func setInitState() {
        
        
        let imageURL = photo?.url
        mainImage.sd_setImage(with: URL(string: imageURL!), placeholderImage: UIImage(named: "placeholder.png"))
        
        mainImage.layer.borderWidth = 10
        mainImage.layer.borderColor = UIColor.purple.cgColor
        mainImage.layer.masksToBounds = true
        
        photoTitle.text = photo?.title ?? ""
        photoTitle.numberOfLines = 0
        photoTitle.sizeToFit()
        photoTitle.textColor = UIColor.purple
        
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
    
    // MARK: - Actions

    
    @IBAction func saveImageButtonTapped(_ sender: UIButton) {
        
         UIImageWriteToSavedPhotosAlbum(mainImage.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        
        let imageToShare = [ mainImage.image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
}

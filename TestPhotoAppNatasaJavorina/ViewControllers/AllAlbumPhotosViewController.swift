//
//  AllAlbumPhotosViewController.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/12/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit
import SDWebImage

class AllAlbumPhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var album: Album?
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Collectiom view data source and delegate methods


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album?.photos?.count ?? 0

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllPhotosCollectionViewCell", for: indexPath) as! AllPhotosCollectionViewCell
        
        let imageURL = album?.photos?[indexPath.row].url
        
        cell.mainImage.sd_setImage(with: URL(string: imageURL!), placeholderImage: UIImage(named: "placeholder.png"))
        

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SinglePhotoViewController") as! SinglePhotoViewController
        vc.photo = album?.photos![indexPath.item]
        

        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController?.view.layer.add(transition, forKey: nil)
//        _ = self.navigationController?.popToRootViewController(animated: false)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds

        let deviceWidth = bounds.size.width
        let cellWidth = deviceWidth/3 - 10
        return CGSize(width: cellWidth, height: cellWidth)
        
    }
}

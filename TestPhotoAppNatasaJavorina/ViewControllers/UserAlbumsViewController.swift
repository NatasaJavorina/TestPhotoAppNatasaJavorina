//
//  UserAlbumsViewController.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/13/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit
import SDWebImage

class UserAlbumsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var user: User?
    
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsers()
        userNameLabel.text = user?.name

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Functions
    
    func getUsers() {
        
        if user?.albums == nil {
            
            DataService.getAlbumsSingleUser(user: user!) { (success, albumsArray2) in
                if success {
                    self.user?.albums = albumsArray2
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                    for eachAlbum in (self.user?.albums)! {
                        self.getPhotosWithAlbumId(albumId: eachAlbum.albumId, completion: { (photos) in
                            eachAlbum.photos = photos
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        })
                    }
                }
            }
            
            
            
        }
        
        
        
    }
    
    func getPhotosWithAlbumId(albumId: Int, completion: @escaping ([Photo]) -> ()) {
        
        DataService.getPhotos(albumId: albumId) { (success, photoArray2) in
            if success {
                var photoArray = photoArray2!
                completion(photoArray)
            }
        }
        
    }
    
    // MARK: - Collection view data source and delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let albumCount = user?.albums?.count else {return 0}
        return albumCount
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserAlbumCollectionViewCell", for: indexPath) as! UserAlbumCollectionViewCell
        
        let album = user?.albums![indexPath.row]
        cell.titleLabel.text = album?.title
        if album?.photos?.count != nil {
            let photosArray: [Photo] = (album?.photos)!
            
            let imageURL = photosArray[0].thumbnailUrl
            cell.mainImage?.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
            
        }
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AllAlbumPhotosViewController") as! AllAlbumPhotosViewController
        
        vc.album = user?.albums![indexPath.item]
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}

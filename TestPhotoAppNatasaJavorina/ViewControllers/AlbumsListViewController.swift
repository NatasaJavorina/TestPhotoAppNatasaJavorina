//
//  AlbumsListViewController.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/12/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit
import SDWebImage


class AlbumsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var albumsArray = [Album]()

    
    @IBOutlet var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitState()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

     // MARK: - Functions
    
    func setInitState() {
        
   
        
        getAlbums()
        
    }
    
    func getAlbums() {
        DataService.getAlbums { (success, albumsArrayTemp) in
            DispatchQueue.main.async {
                if success {
                    
                    self.albumsArray = albumsArrayTemp!
                    self.tableView.reloadData()

                    for eachAlbum in self.albumsArray {
                        self.getPhotosWithAlbumID(albumId: eachAlbum.albumId, completion: { (photoArrayTemp) in
                            eachAlbum.photos = photoArrayTemp
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        })
                    }
                    
                }
            }
        }
    }
    
    func getPhotosWithAlbumID(albumId: Int, completion: @escaping ([Photo]) -> ()) {
        
        DataService.getPhotos(albumId: albumId) { (success, photosArray2) in
            if success {
                var photosArray = photosArray2!
                completion(photosArray)
            }
        }
    }
    

    // MARK: - Table view data source and delegate methods
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsArray.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsListTableViewCell", for: indexPath) as! AlbumsListTableViewCell

        let index = indexPath.row
        cell.mainLabel.text = albumsArray[index].title
        
        if albumsArray[index].photos?.count != nil {
            
            let photosArray: [Photo] = albumsArray[index].photos!
            let imageURL = photosArray[0].thumbnailUrl
            cell.thumbImage?.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

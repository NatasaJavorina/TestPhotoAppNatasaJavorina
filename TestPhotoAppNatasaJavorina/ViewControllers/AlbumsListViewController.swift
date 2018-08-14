//
//  AlbumsListViewController.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/12/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit
import SDWebImage


class AlbumsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var albumsArray = [Album]()
    var searchArray = [Album]()
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var searchTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitState()

        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

     // MARK: - Functions
    
    func setInitState() {
    
        getAlbums()
        
        searchArray = []
        
        searchTextfield.delegate = self
        searchTextfield.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        
    }
    
    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        searchArray.removeAll()
        
        if searchTextfield.text?.count != 0 {
            
            for cand in albumsArray {
                let candString: String = cand.title
                let range = candString.uppercased().range(of: searchTextfield.text!, options: .caseInsensitive, range: nil,   locale: nil)
                
                if range != nil {
                    searchArray.append(cand)
                    
                }
            }
            
            albumsArray = searchArray
        } else {
            
            return
        }
        tableView.reloadData()
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
    

    // MARK: - Actions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        setInitState()
        searchTextfield.text = ""
        tableView.reloadData()
        
    }
    
    
    
    // MARK: - Table view data source and delegate methods
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsArray.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsListTableViewCell", for: indexPath) as! AlbumsListTableViewCell

        let index = indexPath.row
        
        cell.mainLabel.text = albumsArray[index].title.uppercased()
        
        if albumsArray[index].photos?.count != nil {
            
            let photosArray: [Photo] = albumsArray[index].photos!
            let imageURL = photosArray[0].thumbnailUrl
            cell.thumbImage?.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AllAlbumPhotosViewController") as! AllAlbumPhotosViewController
        vc.album = albumsArray[indexPath.item]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

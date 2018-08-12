//
//  AlbumsListViewController.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/12/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit

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

                    
                }
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
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

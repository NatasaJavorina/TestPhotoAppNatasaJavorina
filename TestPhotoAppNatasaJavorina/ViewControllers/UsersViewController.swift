//
//  UsersViewController.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/13/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit
import MDHTMLLabel

class UsersViewController: UIViewController, MDHTMLLabelDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var usersArray = [User]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUsers()
    }
    
    func getUsers() {
        
        DataService.getUsers { (success, userArray2) in
            DispatchQueue.main.async {
                if success {
                    self.usersArray = userArray2!
                    self.tableView.reloadData()
                    
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Table view data source and delegate methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        
        let user = usersArray[indexPath.row]
        
    
        cell.nameLabel.text = user.name
        cell.usernameLabel.text = user.username
        
        let urlStringLong = "http://www." + user.website
        let urlShowed = user.website
        let ahrefString = "<a href='\(urlStringLong)'>\(urlShowed)</a>"
        
        cell.websiteLabel.delegate = self
        cell.websiteLabel.htmlText = ahrefString
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserAlbumsViewController") as! UserAlbumsViewController
        
        let oneUser = usersArray[indexPath.row]
        vc.user = oneUser
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    
    
    func htmlLabel(_ label: MDHTMLLabel?, didSelectLinkWith URL: URL?) {
        
        if let anURL = URL {
            UIApplication.shared.open(anURL, options: [:], completionHandler: nil)
        }
    }
}

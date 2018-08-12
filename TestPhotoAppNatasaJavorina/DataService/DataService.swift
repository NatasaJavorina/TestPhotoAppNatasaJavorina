//
//  DataService.swift
//  TestPhotoAppNatasaJavorina
//
//  Created by Natasa Javorina on 8/12/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import Foundation

class DataService {
    
    static let baseUrl = "https://jsonplaceholder.typicode.com"

    typealias getAlbumsCompletionHandler = (Bool, [Album]?) -> Void
    typealias getPhotosCompletionHandler = (Bool, [Photo]?) -> Void
    typealias getUsersCompletionHandler = (Bool, [User]?) -> Void
    
    
    static func getAlbums(completionHandler: @escaping getAlbumsCompletionHandler) {
        
        let endpoint = "/albums"
        
        let url = URL(string: DataService.baseUrl+endpoint)!
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                completionHandler(false, nil)
            } else {
                do {
                    if let albumsJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [JSON] {
                        
                        let album = albumsJSON.map({Album(dict: $0)})
                        completionHandler(true, album)
                    } else {
                        completionHandler(false, nil)
                    }
                } catch {
                    completionHandler(false, nil)
                }
            }
        }
        task.resume()
    }
    
    static func getPhotos(albumId: Int, completionHandler: @escaping getPhotosCompletionHandler) {
        
        let endpoint = "/albums/" + "\(albumId)" + "/photos"
        
        let url = URL(string: DataService.baseUrl+endpoint)!
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                completionHandler(false, nil)
            } else {
                do {
                    if let photosJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [JSON] {
                        
                        let photo = photosJSON.map { Photo(dict: $0) }
                        completionHandler(true, photo)
                    } else {
                        completionHandler(false, nil)
                    }
                } catch {
                    completionHandler(false, nil)
                }
            }
        }
        task.resume()
    }

    static func getAlbumsSingleUser(user: User, completionHandler: @escaping getAlbumsCompletionHandler) {
        
        let endpoint = "/users/" + "\(user.userId)" + "/albums"
        
        
        let url = URL(string: DataService.baseUrl+endpoint)!
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                completionHandler(false, nil)
            } else {
                do {
                    if let albumsJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [JSON] {
                        
                        let album = albumsJSON.map({Album(dict: $0)})
                        completionHandler(true, album)
                    } else {
                        completionHandler(false, nil)
                    }
                } catch {
                    completionHandler(false, nil)
                }
            }
        }
        task.resume()
    }
    
    
    static func getUsers(completionHandler: @escaping getUsersCompletionHandler) {
        
        let endpoint = "/users"
        
        let url = URL(string: DataService.baseUrl+endpoint)!
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                completionHandler(false, nil)
            } else {
                do {
                    if let usersJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [JSON] {
                        
                        let users = usersJSON.map { User(dict: $0) }
                        completionHandler(true, users)
                    } else {
                        completionHandler(false, nil)
                    }
                } catch {
                    completionHandler(false, nil)
                }
            }
        }
        task.resume()
    }

    
    
}

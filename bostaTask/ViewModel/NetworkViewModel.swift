//
//  NetworkViewModel.swift
//  bostaTask
//
//  Created by Mahmoud on 03/03/2023.
//

import Foundation
class ViewModel{
    //MARK: property of users
    var bindingUserResult : (()->()) = {}
    var usersResult : [User]!{
        didSet{
            bindingUserResult()
        }
    }
    
    //MARK: property of albums
    var bindingAlbumsResult : (()->()) = {}
    var albumsResult : [Album]!{
        didSet{
            bindingAlbumsResult()
        }
    }
    
    //MARK: property of photos
    var bindingPhotosResult : (()->()) = {}
    var photosResult : [Photo]!{
        didSet{
            bindingPhotosResult()
        }
    }
    
    func fetchUsersData(url : URL){
        NetworkServiece.fetch(url: url) { result in
            self.usersResult = result
        }
        
    }
    
    func fetchAlbumsData(url : URL){
        NetworkServiece.fetch(url: url) { result in
            self.albumsResult = result
        }
    }
    
    func fetchPhotosData(url : URL){
        NetworkServiece.fetch(url: url) { result in
            self.photosResult = result
        }
    }
    
}


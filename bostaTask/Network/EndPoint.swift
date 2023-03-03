//
//  EndPoint.swift
//  bostaTask
//
//  Created by Mahmoud on 03/03/2023.
//

import Foundation

enum EndPoint{
    case users
    case albums
    case photos
    case albumId
    case photoId
    var path : String{
        switch self{
        case.users:
            return "/users"
        case .albums:
            return "/albums"
        case .photos:
            return "/photos"
        case .albumId:
            return "/albums?userId="
        case .photoId:
            return "/photos?albumId="
            
        }

    }
    
    func makeUrl(baseUrl : String)->URL{
        let url = "\(baseUrl)\(self.path)"
        return URL(string: url)!
    }
    func makeUrlWithId(baseUrl : String,id : String)->URL{
        let url = "\(baseUrl)\(self.path)\(id)"
        return URL(string: url)!
    }
}

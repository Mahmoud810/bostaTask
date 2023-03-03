//
//  NetworkService.swift
//  bostaTask
//
//  Created by Mahmoud on 03/03/2023.
//

import Foundation
import Alamofire
class NetworkServiece {
    static var baseUrl  = "https://jsonplaceholder.typicode.com"
    
    // MARK: Generic fetch method
    static func fetch<T:Decodable>(url : URL,compiletionHandler : @escaping(T?)->Void){
        AF.request(url).validate().responseDecodable(of: T.self){
            data in
            guard let data = data.value else{
                compiletionHandler(nil)
                return
                
            }
            compiletionHandler(data)
        }
        
    }
  
}

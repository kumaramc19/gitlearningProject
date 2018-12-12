//
//  ConnectionHandler.swift
//  AdvertisementListTask
//
//  Created by rakesh on 24/11/18.
//  Copyright © 2018 rakesh. All rights reserved.
//

import Foundation
import UIKit

final class ConnectionHandler {
    static let shared = ConnectionHandler()
    private init() {
        //print("Singleton initialized")
    }
    
    func getAPI ( url : String , completionHandler : @escaping( _ result : [String : Any]? , _ error : Error? ) -> Void ) {
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    // if let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String:Any] {
                    // print(json)
                    // completionHandler( json , nil )
                    // }
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                 //   print("Response:\(json)")
                    completionHandler( json , nil )
                } catch {
                    completionHandler(nil, error)
                }
            }
            }.resume()
    }
    
    func postAPI( url : String , post params : [String : Any] , completionHandler:@escaping (_ result : [String : Any]? , _ error : Error?) -> Void) {
       // print("API Url :\(url) - Params:\(params)")
        guard let serviceUrl = URL(string: url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    //                    if let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String:Any] {
                    //                        print(json)
                    //                        completionHandler( json , nil )
                    //                    }
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                    completionHandler( json , nil )
                } catch {
                    completionHandler(nil, error)
                }
            }
            }.resume()
    }
}


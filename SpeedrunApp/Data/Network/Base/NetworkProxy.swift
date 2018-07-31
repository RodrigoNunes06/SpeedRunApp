//
//  NetworkProxy.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 29/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation
import ObjectMapper

class NetworkProxy {
    
    func process<T: Mappable>( networkRequest: NetworkRequest, completion: @escaping(T?, Error?) -> Void) {
        Network.shared.requestObject(networkRequest: networkRequest) { (object: T?, error) in
            if let error = error {
                 completion(nil, error)
            } else if let object = object {
                 completion(object, nil)
            }
        }
    }
    
    func processArray<T: Mappable>( networkRequest: NetworkRequest, completion: @escaping([T]?, Error?) -> Void) {
        Network.shared.requestArray(networkRequest: networkRequest) { (objectArray: [T]?, error) in
            if let error = error {
                completion(nil, error)
            } else if let objectArray = objectArray {
                completion(objectArray, nil)
            }
        }
    }
    
}

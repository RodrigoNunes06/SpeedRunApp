//
//  AppService.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 30/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation
import ObjectMapper

final class AppService: NetworkProxy {
    
    func requestGameList(completion: @escaping([GameEntity]?, Error?) -> Void) {
        let serviceRequest = NetworkRequest()
        serviceRequest.path = Api.pathGames
        
        processArray(networkRequest: serviceRequest) { (objectArray, error) in
            completion(objectArray, error)
        }
    }
    
    func requestGame(withId id: String, completion: @escaping(GameEntity?, Error?) -> Void) {
        let serviceRequest = NetworkRequest()
        serviceRequest.path = Api.pathUsers
        serviceRequest.parameters = ["userId" : id]
        
        process(networkRequest: serviceRequest) { (object, error) in
            completion(object, error)
        }
    }
    
}

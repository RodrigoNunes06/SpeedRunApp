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
        serviceRequest.method = .get
        
        processArray(networkRequest: serviceRequest) { (objectArray, error) in
            completion(objectArray, error)
        }
    }
    
    func requestGame(withId id: String, completion: @escaping(GameEntity?, Error?) -> Void) {
        let serviceRequest = NetworkRequest()
        serviceRequest.path = String(format: Api.pathGame, id)
        serviceRequest.method = .get
        
        process(networkRequest: serviceRequest) { (object, error) in
            completion(object, error)
        }
    }
    
    func requestUser(withId id:String, completion: @escaping(UserEntity?, Error?) -> Void) {
        let serviceRequest = NetworkRequest()
        serviceRequest.path = String(format: Api.pathUser, id)
        serviceRequest.method = .get
        
        process(networkRequest: serviceRequest) { (object, error) in
            completion(object, error)
        }
    }
    
    func requestRuns(withId id: String, completion: @escaping([RunEntity]?, Error?) -> Void) {
        let serviceRequest = NetworkRequest()
        serviceRequest.path = String(format: Api.pathRun, id)
        serviceRequest.method = .get
        
        processArray(networkRequest: serviceRequest) { (objectArray, error) in
            completion(objectArray, error)
        }
    }
    
}

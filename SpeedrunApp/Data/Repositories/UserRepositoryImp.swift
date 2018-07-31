//
//  UserRepositoryImp.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 31/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

final class UserRepositoryImp: UserRepository {
    
    private var restAPI = AppService()
    
    func user(withId id: String, completion: @escaping (User?, Error?) -> Void) {
        restAPI.requestUser(withId: id) { (userEntity, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let user = UserEntityDataMapper().transform(entity: userEntity)
                completion(user, nil)
            }
        }
    }
    
}

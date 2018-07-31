//
//  UserEntityDataMapper.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 30/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

final class UserEntityDataMapper {
    
    func transform(entity: UserEntity?) -> User {
        let domain = User()
        if let entity = entity {
            if let id = entity.id {
                domain.id = id
            }
            if let name = entity.name {
                domain.name = name
            }
        }
        
        return domain
    }
    
}

//
//  GameEntityDataMapper.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 30/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

final class GameEntityDataMapper {
    
    func transform(entity: GameEntity?) -> Game {
        let domain = Game()
        
        if let entity = entity {
            if let id = entity.id {
                domain.id = id
            }
            if let name = entity.name {
                domain.name = name
            }
            if let gameLogoURL = entity.gameLogoURL {
                domain.gameLogoURL = gameLogoURL
            }
        }
        
        return domain
    }
    
}

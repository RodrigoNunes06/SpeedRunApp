//
//  GameEntity.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 30/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation
import ObjectMapper

final class GameEntity: Mappable {
    
    var id: String? = nil
    var name: String? = nil
    var gameLogoURL: String? = nil
    
    init() {}
    
    init?(map: Map) {}
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["names.international"]
        gameLogoURL <- map["assets.cover-large.uri"]
    }
    
}

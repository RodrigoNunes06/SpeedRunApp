//
//  Game.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 30/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation
import ObjectMapper

final class Game: Mappable {
    
    var id: String = ""
    var name: String = ""
    var gameLogoURL: String = ""
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id             <- map["id"]
        name           <- map["name"]
        gameLogoURL    <- map["gameLogoURL"]
    }
    
}

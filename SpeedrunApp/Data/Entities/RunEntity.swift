//
//  RunEntity.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 2/8/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation
import ObjectMapper

final class RunEntity: Mappable {
    
    var id: String? = nil
    var videoLink: String? = nil
    var players: [User]? = nil
    var runTime: Int? = nil
    var comment: String? = nil
    
    init() {}
    
    init?(map: Map) {}
    
    func mapping(map: Map) {
        id              <- map["id"]
        videoLink      <- map["videos.links.0.uri"]
        players         <- map["players"]
        runTime         <- map["times.primary_t"]
        comment         <- map["comment"]
    }
    
}

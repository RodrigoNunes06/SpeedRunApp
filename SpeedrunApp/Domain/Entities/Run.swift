//
//  Run.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 2/8/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation
import ObjectMapper

final class Run: Mappable {
    
    var id: String = ""
    var videoLink: String = ""
    var players: [User] = []
    var runTime: Int = 0
    var comment: String = ""
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id              <- map["id"]
        videoLink      <- map["videos.links.0.uri"]
        players         <- map["players"]
        runTime         <- map["times.primary_t"]
        comment         <- map["comment"]
    }
    
}

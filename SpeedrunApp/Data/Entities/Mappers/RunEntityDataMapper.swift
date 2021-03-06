//
//  RunEntityDataMapper.swift
//  
//
//  Created by Rodrigo Nunes on 2/8/18.
//

import Foundation

final class RunEntityDataMapper {
    
    func transform(entity: RunEntity?) -> Run {
        let domain = Run()
        if let entity = entity {
            if let id = entity.id {
                domain.id = id
            }
            if let players = entity.players {
                domain.players = players.map { userEntity in
                    UserEntityDataMapper().transform(entity: userEntity)
                }
            }
            if let runTime = entity.runTime {
                domain.runTime = runTime
            }
            if let videoLink = entity.videoLink {
                domain.videoLink = videoLink
            }
        }
        
        return domain
    }
    
}

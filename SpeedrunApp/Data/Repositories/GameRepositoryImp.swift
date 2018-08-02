//
//  GameRepositoryImp.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 31/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

final class GameRepositoryImp: GameRepository {
    
    private var restAPI = AppService()
    
    func game(withId id: String, completion: @escaping (Game?, Error?) -> Void) {
        restAPI.requestGame(withId: id) { (gameEntity, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let game = GameEntityDataMapper().transform(entity: gameEntity)
                completion(game, nil)
            }
        }
    }
    
    func gamesList(completion: @escaping([Game]?, Error?) -> Void) {
        restAPI.requestGameList { (gameEntityList, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let gameList = gameEntityList?.map({ (gameEntity) -> Game in
                    return GameEntityDataMapper().transform(entity: gameEntity)
                })
                completion(gameList, nil)
            }
        }
    }
    

    
}

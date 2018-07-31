//
//  GetGamesListUseCase.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 31/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

final class GetGamesListUseCase: BaseUseCase<GameRepository> {
    
    init() {
        super.init(repository: GameRepositoryImp())
    }
    
    func execute(completion: @escaping([Game]?, Error?) -> Void) {
        repository.gamesList(completion: { (gamesArray, error) in
            completion(gamesArray,error)
        })
    }
    
}

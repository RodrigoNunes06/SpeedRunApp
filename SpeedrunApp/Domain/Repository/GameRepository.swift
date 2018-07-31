//
//  GameRepository.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 30/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

protocol GameRepository {
    
    func gamesList(completion: @escaping([Game]?, Error?) -> Void)
    
    func game(withId id: String, completion: @escaping(Game?, Error?) -> Void)
    
}

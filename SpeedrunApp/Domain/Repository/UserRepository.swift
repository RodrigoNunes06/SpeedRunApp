//
//  UserRepository.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 30/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

protocol UserRepository {
    
    func user(withId id: String, completion: @escaping (User?, Error?) -> Void)
    
}

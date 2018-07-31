//
//  BaseUseCase.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 31/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

class BaseUseCase<T> {
    
    let repository: T
    
    init(repository: T) {
        self.repository = repository
    }
    
}

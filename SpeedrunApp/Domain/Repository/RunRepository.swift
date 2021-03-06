//
//  RunRepository.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 2/8/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

protocol RunRepository {
    
    func runs(withId id:String, completion:  @escaping ([Run]?, Error?) -> Void)
    
}

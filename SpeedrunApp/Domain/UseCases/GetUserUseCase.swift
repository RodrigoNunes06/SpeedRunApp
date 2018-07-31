//
//  GetUserUseCase.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 31/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

final class GetUserUseCase: BaseUseCase<UserRepository> {
    
    init() {
        super.init(repository: UserRepositoryImp())
    }
    
    func execute(withId id: String, completion: @escaping(User?, Error?) -> Void) {
        repository.user(withId: id) { (user, error) in
            completion(user, error)
        }
    }
    
}

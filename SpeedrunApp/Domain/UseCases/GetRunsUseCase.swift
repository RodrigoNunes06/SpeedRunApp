//
//  GetRunsUseCase.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 2/8/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

final class GetRunsUseCase: BaseUseCase<RunRepository> {
    
    init() {
        super.init(repository: RunRepositoryImp())
    }
    
    func execute(withId id: String, completion: @escaping([Run]?, Error?) -> Void) {
        repository.runs(withId: id) { (runsArray, error) in
            completion(runsArray, error)
        }
    }
    
}

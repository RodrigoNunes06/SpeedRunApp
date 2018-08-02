//
//  RunRepositoryImp.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 2/8/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

final class RunRepositoryImp: RunRepository {
    
    private var restAPI = AppService()
    
    func runs(withId id: String, completion: @escaping ([Run]?, Error?) -> Void) {
        restAPI.requestRuns(withId: id) { (runEntityArray, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let runsArray = runEntityArray?.map({ (runEntity) -> Run in
                    return RunEntityDataMapper().transform(entity: runEntity)
                })
                completion(runsArray, nil)
            }
        }
    }
    
    
}

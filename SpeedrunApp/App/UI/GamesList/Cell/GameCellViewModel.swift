//
//  GameCellViewModel.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 1/8/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation
import RxSwift

class GameCellViewModel {
    
    let gameName = BehaviorSubject<String>(value: "")
    let gameLogo = BehaviorSubject<String>(value: "")
    
    required init(with gameName: String? = "", gameLogo: String? = "" ) {
        if let name = gameName {
            self.gameName.onNext(name)
        }
        if let gameLogo = gameLogo {
            self.gameLogo.onNext(gameLogo)
        }
    }
    
}

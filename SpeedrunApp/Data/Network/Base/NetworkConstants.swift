//
//  NetworkConstants.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 29/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation

struct Api {
    
    static let baseURL = "https://www.speedrun.com/api/v1"
    
    static let headerAuthorizationKey = "Authorization"
    static let headerContentTypeKey = "Content-Type"
    static let headerAcceptTypeKey = "Accept"
    static let headerBearerKey = "Bearer"
    static let headerContentTypeValue = "application/json"
    static let headerAcceptedLanguage = "Accept-Language"
    
    static let pathGames = "/games"
    static let pathUsers = "/users"
    static let pathRuns = "/runs"
    
    static let pathGame = "/games/%@"
    static let pathUser = "/users/%@"
    static let pathRun = "/runs?game=%@"
}

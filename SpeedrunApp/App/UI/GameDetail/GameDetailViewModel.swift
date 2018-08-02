//
//  GameDetailViewModel.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 2/8/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import Action

class GameDetailViewModel {
    
    let gameLogo = BehaviorSubject<String>(value: "")
    let gameTitle = BehaviorSubject<String>(value: "")
    let firstRunDetail = BehaviorSubject<String>(value: "")
    let playerName = BehaviorSubject<String>(value: "")
    let runTimeLabel = BehaviorSubject<String>(value: "")
    var gameId = ""
    var userId = ""
    var videoURL = ""
    
    func setup(gameLogo: String? = nil, gameTitle: String? = nil, firstRunDetail: String? = nil, playerName: String? = nil, runTimeLabel: String? = nil) {
        if let gameLogo = gameLogo {
            self.gameLogo.onNext(gameLogo)
        }
        if let gameTitle = gameTitle {
            self.gameTitle.onNext(gameTitle)
        }
        if let firstRunDetail = firstRunDetail {
            self.firstRunDetail.onNext(firstRunDetail)
        }
        if let playerName = playerName {
            self.playerName.onNext(playerName)
        }
        if let runTimeLabel = runTimeLabel {
            self.runTimeLabel.onNext(runTimeLabel)
        }
    }
    
    func onViewWillAppear() {
        requestRun(withId: gameId)
        requestUser(withId: userId)
    }
    
    func openVideo() {
        if let url = URL(string: videoURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: {
                (success) in
                print("Open \(self.videoURL): \(success)")
            })
        }
    }
    
    func requestRun(withId id: String) {
        
    }
    
    func requestUser(withId id: String) {
        
    }
}

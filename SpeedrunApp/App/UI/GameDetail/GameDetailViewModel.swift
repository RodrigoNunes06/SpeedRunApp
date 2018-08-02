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

class GameDetailViewModel {
    
    let getRunsUseCase = GetRunsUseCase()
    let getUserUseCase = GetUserUseCase()
    let gameLogo = BehaviorSubject<String>(value: "")
    let gameTitle = BehaviorSubject<String>(value: "")
    let firstRunDetail = BehaviorSubject<String>(value: "")
    let playerName = BehaviorSubject<String>(value: "")
    let runTime = BehaviorSubject<Int>(value: 0)
    var gameId = ""
    var userId = ""
    var videoURL = ""
    
    func setup(gameLogo: String? = nil, gameTitle: String? = nil, firstRunDetail: String? = nil, playerName: String? = nil, runTime: Int? = nil) {
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
        if let runTime = runTime {
            self.runTime.onNext(runTime)
        }
    }
    
    func onViewWillAppear() {
        requestRun(withId: gameId)
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
        getRunsUseCase.execute(withId: id) { (runsArray, error) in
            if let error = error {
                print("ApiError: \(error.localizedDescription)")
            } else if let runsArray = runsArray {
                if let run = runsArray.first {
                    if let player = run.players.first {
                        self.requestUser(withId: player.id)
                    }
                    self.videoURL = run.videoLink
                    self.setup(firstRunDetail: run.comment,runTime: run.runTime)
                }
            }
        }
    }
    
    func requestUser(withId id: String) {
        getUserUseCase.execute(withId: id) { (user, error) in
            if let error = error {
                print("ApiError: \(error.localizedDescription)")
            } else if let user = user {
                self.setup(playerName: user.name)
            }
        }
    }
}

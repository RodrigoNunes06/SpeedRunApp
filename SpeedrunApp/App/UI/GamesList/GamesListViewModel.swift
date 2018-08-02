//
//  GamesListViewModel.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 31/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation
import RxSwift
import Action

class GamesListViewModel {
    
    var presenter = UIViewController()
    var games: [Game] = []
    let getGamesUseCase = GetGamesListUseCase()
    let reloadAction = CocoaAction { return .empty() }
    
    func onViewWillAppear() {
        requestGames()
    }
    
    func setupViewModel(withPresenter presenter:UIViewController) {
        self.presenter = presenter
    }
    
    func numberOfRows(section: Int) -> Int {
        return games.count
    }
    
    func cellIdentifier() -> String {
        return GameCell.reuseIdentifier()
    }
    
    func cellViewModel(indexPath: IndexPath) -> GameCellViewModel {
        let game = games[indexPath.row]
        
        return GameCellViewModel(with: game.name, gameLogo: game.gameLogoURL)
    }
    
    func showGameDetail(indexPath: IndexPath) {
        let game = games[indexPath.row]
        let gameDetail = GameDetailViewController()
        
        gameDetail.viewModel.gameId = game.id
        gameDetail.viewModel.setup(gameLogo: game.gameLogoURL, gameTitle: game.name)
        presenter.navigationController?.pushViewController(gameDetail, animated: true)
    }
    
    func requestGames() {
        getGamesUseCase.execute { (gamesArray, error) in
            if let error = error {
                print("ApiError: \(error)")
            } else if let gamesArray = gamesArray {
                self.games = gamesArray
                self.reloadAction.execute(())
            }
        }
    }
    
}

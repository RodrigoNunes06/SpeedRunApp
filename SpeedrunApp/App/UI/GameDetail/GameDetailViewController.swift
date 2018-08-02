//
//  GameDetailViewController.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 2/8/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class GameDetailViewController: UIViewController {
    
    @IBOutlet weak var gameLogoImageView: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var firstRunLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var watchVideoButton: UIButton!
    
    var viewModel: GameDetailViewModel!
    var disposeBag = DisposeBag()
    
    //MARK: Initializer
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewModel = createViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
        setupRx()
    }
    
    private func createViewModel() -> GameDetailViewModel {
        return GameDetailViewModel()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Game Detail"
        self.navigationController?.navigationBar.barTintColor = .gray
    }
    
    private func setupUI() {
        watchVideoButton.setTitle("Watch Video", for: .normal)
        watchVideoButton.layer.cornerRadius = 5
        watchVideoButton.clipsToBounds = true
    }
    
    private func setupRx() {
        viewModel.gameTitle.subscribe(onNext: { [weak self] title in
            guard let `self` = self else { return }
            
            self.gameTitle.text = title
        }).disposed(by: disposeBag)
        
        viewModel.gameLogo.subscribe(onNext: { [weak self] logoUrl in
            guard let `self` = self else { return }
            
            self.gameLogoImageView.kf.setImage(with: URL(string: logoUrl))
        }).disposed(by: disposeBag)
        
        viewModel.firstRunDetail.subscribe(onNext: { [weak self] firstRunDetail in
            guard let `self` = self else { return }
            
            self.firstRunLabel.text = firstRunDetail
        }).disposed(by: disposeBag)
        
        viewModel.playerName.subscribe(onNext: { [weak self] playerName in
            guard let `self` = self else { return }
            
            self.playerNameLabel.text = playerName
        }).disposed(by: disposeBag)
        
        watchVideoButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            
            self.viewModel.openVideo()
        })
    }
    
}

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
import NVActivityIndicatorView

class GameDetailViewController: UIViewController {
    
    @IBOutlet weak var gameLogoImageView: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var firstRunLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var watchVideoButton: UIButton!
    
    var viewModel: GameDetailViewModel!
    var disposeBag = DisposeBag()
    var activityIndicator: NVActivityIndicatorView!
    
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
        
        setupActivityIndicator()
        setupNavigationBar()
        setupUI()
        setupRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.onViewWillAppear()
    }
    
    private func createViewModel() -> GameDetailViewModel {
        return GameDetailViewModel()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Game Detail"
        self.navigationController?.navigationBar.barTintColor = .gray
    }
    
    private func setupActivityIndicator() {
        let xCenter = self.view.center.x
        let yCenter = self.view.center.y
        let indicatorHeight: CGFloat = 45.0
        let indicatorWidth: CGFloat = 45.0

        let frame = CGRect(x: xCenter - indicatorWidth/2, y: yCenter - indicatorHeight/2, width: indicatorWidth, height: indicatorHeight)
        activityIndicator = NVActivityIndicatorView(frame: frame)
        activityIndicator.type = .ballBeat
        activityIndicator.color = UIColor.red
        
        self.view.addSubview(activityIndicator)
    }
    
    private func setupUI() {
        watchVideoButton.setTitle("Watch Video", for: .normal)
        watchVideoButton.layer.cornerRadius = 5
        watchVideoButton.clipsToBounds = true
    }
    
    private func setupRx() {
        viewModel.gameTitle.subscribe(onNext: { [weak self] title in
            guard let `self` = self else { return }
            
            self.gameTitle.text = title == "" ? "N/A" : title
        }).disposed(by: disposeBag)
        
        viewModel.gameLogo.subscribe(onNext: { [weak self] logoUrl in
            guard let `self` = self else { return }
            
            self.gameLogoImageView.kf.setImage(with: URL(string: logoUrl))
        }).disposed(by: disposeBag)
        
        viewModel.firstRunDetail.subscribe(onNext: { [weak self] firstRunDetail in
            guard let `self` = self else { return }
            
            let detail = firstRunDetail == "" ? "N/A" : firstRunDetail
            
            self.firstRunLabel.text = "Details: " + detail
        }).disposed(by: disposeBag)
        
        viewModel.playerName.subscribe(onNext: { [weak self] playerName in
            guard let `self` = self else { return }
            
            let player = playerName == "" ? "N/A" : playerName
            
            self.playerNameLabel.text = "Player Name: " + player
        }).disposed(by: disposeBag)
        
        viewModel.runTime.subscribe(onNext: { [weak self] time in
            guard let `self` = self else { return }
            
            self.runTimeLabel.text = "Run Time: " + self.secondsToTimeString(seconds: time)
        }).disposed(by: disposeBag)
        
        watchVideoButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            
            self.viewModel.openVideo()
        }).disposed(by: disposeBag)
        
        viewModel.showLoadingAction.inputs.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            
            self.activityIndicator.startAnimating()
        }).disposed(by: disposeBag)
        
        viewModel.hideLoadingAction.inputs.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            
            self.activityIndicator.stopAnimating()
        }).disposed(by: disposeBag)
    }
    
    private func secondsToTime(seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func secondsToTimeString(seconds: Int) -> String {
        let (h, m, s) = secondsToTime(seconds: seconds)
        return "\(h)h \(m)m \(s)s"
    }
    
}

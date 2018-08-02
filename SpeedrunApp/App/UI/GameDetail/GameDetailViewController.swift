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
    var disposeBarg = DisposeBag()
    
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
        setupRx()
    }
    
    private func createViewModel() -> GameDetailViewModel {
        return GameDetailViewModel()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Game Detail"
        self.navigationController?.navigationBar.barTintColor = .gray
    }
    
    private func setupRx() {
        
    }
    
}

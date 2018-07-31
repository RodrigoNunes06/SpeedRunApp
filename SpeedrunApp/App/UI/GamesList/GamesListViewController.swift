//
//  GamesListViewController.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 31/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import UIKit
import RxSwift

class GamesListViewController: UIViewController {
    
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    
    var viewModel: GamesListViewModel!
    
    //MARK: Initalizers
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
    }
    
    //MARK: Private Methods
    private func createViewModel() -> GamesListViewModel {
        return GamesListViewModel()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Games List"
    }
    
}



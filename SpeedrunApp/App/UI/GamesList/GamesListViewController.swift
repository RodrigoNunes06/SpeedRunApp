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
    var disposeBag = DisposeBag()
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    private let itemWidth = 180
    private let itemHeight = 300
    private let horizontalMargin: CGFloat = 17.0
    private let verticalMargin: CGFloat = 17.0
    private let minimumCellSpacing: CGFloat = 10.0
    
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
        setupCollectionView()
        setupFlowLayout()
        setupRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.onViewWillAppear()
    }
    
    //MARK: Private Methods
    private func createViewModel() -> GamesListViewModel {
        return GamesListViewModel()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Games List"
    }

    private func setupFlowLayout() {
        flowLayout.sectionInset = UIEdgeInsetsMake(horizontalMargin, verticalMargin, horizontalMargin, verticalMargin)
        flowLayout.minimumLineSpacing = minimumCellSpacing
        flowLayout.minimumInteritemSpacing = minimumCellSpacing
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.scrollDirection = .vertical
    }
    
    private func setupCollectionView() {
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        gamesCollectionView.backgroundColor = .lightGray
        gamesCollectionView.showsHorizontalScrollIndicator = false
        gamesCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        gamesCollectionView.register(UINib(nibName: GameCell.preferredNibName(), bundle: nil), forCellWithReuseIdentifier: GameCell.reuseIdentifier())
    }
    
    private func setupRx() {
        viewModel.reloadAction.inputs.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            
            self.gamesCollectionView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension GamesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellIdentifier(), for: indexPath)
        
        if let gameCell = collectionViewCell as? GameCell {
            gameCell.set(viewModel: viewModel.cellViewModel(indexPath: indexPath))
        }
        
        return collectionViewCell
    }
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showGameDetail(indexPath: indexPath)
    }
    
}



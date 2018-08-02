//
//  GamesListViewController.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 31/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

class GamesListViewController: UIViewController {
    
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    
    var viewModel: GamesListViewModel!
    var disposeBag = DisposeBag()
    var activityIndicator: NVActivityIndicatorView!
    
    private let flowLayout = UICollectionViewFlowLayout()
    
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
        
        setupActivityIndicator()
        setupViewModel()
        setupNavigationBar()
        setupCollectionView()
        setupFlowLayout()
        setupRx()
        viewModel.onViewDidLoad()
    }
    
    //MARK: Private Methods
    private func createViewModel() -> GamesListViewModel {
        return GamesListViewModel()
    }
    
    private func setupViewModel() {
        viewModel.setupViewModel(withPresenter: self)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Games List"
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

    private func setupFlowLayout() {
        flowLayout.sectionInset = UIEdgeInsetsMake(horizontalMargin, verticalMargin, horizontalMargin, verticalMargin)
        flowLayout.minimumLineSpacing = minimumCellSpacing
        flowLayout.minimumInteritemSpacing = minimumCellSpacing
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .vertical
    }
    
    private func setupCollectionView() {
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        gamesCollectionView.backgroundColor = .gray
        gamesCollectionView.showsHorizontalScrollIndicator = false
        gamesCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        gamesCollectionView.register(UINib(nibName: GameCell.preferredNibName(), bundle: nil), forCellWithReuseIdentifier: GameCell.reuseIdentifier())
    }
    
    private func setupRx() {
        viewModel.reloadAction.inputs.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            
            self.gamesCollectionView.reloadData()
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
}

extension GamesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showGameDetail(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.view.frame.size.height;
        let width  = self.view.frame.size.width;
        
        return CGSize(width: width * 0.4, height: height * 0.3);
    }
}



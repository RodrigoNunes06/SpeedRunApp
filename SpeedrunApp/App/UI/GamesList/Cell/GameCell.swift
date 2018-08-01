//
//  GameCell.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 1/8/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class GameCell: UICollectionViewCell {
    
    @IBOutlet weak var gameLogoImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    var viewModel: GameCellViewModel?
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupRx()
        setupUI()
    }
    
    func set(viewModel: GameCellViewModel) {
        self.viewModel = viewModel
        setupRx()
    }
    
    static func preferredNibName() -> String {
        return String(describing: GameCell.self)
    }
    
    static func reuseIdentifier() -> String {
        return String(describing: GameCell.self)
    }
    
    func setupUI() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
    func setupRx() {
        guard let viewModel = viewModel else { return }
        
        viewModel.gameLogo.subscribe(onNext: { [weak self] imageURL in
            guard let `self` = self else { return }
            
            self.gameLogoImageView.kf.setImage(with: URL(string: imageURL))
        }).disposed(by: disposeBag)
        
        viewModel.gameName.subscribe(onNext: { [weak self] name in
            guard let `self` = self else { return }
            
            self.gameNameLabel.text = name
        }).disposed(by: disposeBag)
    }
    
}


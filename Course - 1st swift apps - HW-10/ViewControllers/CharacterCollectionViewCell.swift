//
//  CharacterCollectionViewCell.swift
//  Course - 1st swift apps - HW-11
//
//  Created by Lev Litvak on 29.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    // MARK: - IB Outlets
    @IBOutlet weak var characterView: UIView!
    @IBOutlet weak var characterImageView: ImageView!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Public metrhods
    func configure(with character: RMCharacter) {
        characterView.layer.cornerRadius = 10
        characterLabel.text = character.name
        
        hideCell()
        characterImageView.getImage(from: character.image ?? "") { 
            self.showCell(character: character)
        }
    }
    
    // MARK: - Private methods
    func hideCell() {
        characterImageView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func showCell(character: RMCharacter) {
        self.activityIndicator.stopAnimating()
        self.characterImageView.isHidden = false
    }
}

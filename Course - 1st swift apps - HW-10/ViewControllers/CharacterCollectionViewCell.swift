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
    @IBOutlet weak var characterImage: ImageView!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Public metrhods
    func configure(with character: RMCharacter) {
        characterView.layer.cornerRadius = 10

        hideCell()
        characterImage.getImage(from: character.image ?? "")
        showCell(character: character)
    }
    
    // MARK: - Private methods
    func hideCell() {
        characterImage.isHidden = true
        characterLabel.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func showCell(character: RMCharacter) {
        characterLabel.text = character.name
        
        self.activityIndicator.stopAnimating()
        self.characterImage.isHidden = false
        self.characterLabel.isHidden = false
    }
}

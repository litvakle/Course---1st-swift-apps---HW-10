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
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Public metrhods
    func configure(with character: RMCharacter) {
        characterView.layer.cornerRadius = 10
        
        hideCell()
        
        let index = character.id
        if let image = Images.shared.images[index] {
            showCell(character, image)
        } else {
            DispatchQueue.global().async {
                guard let imageData = Images.shared.getImageData(from: character.image) else { return }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        self.showCell(character, image)
                        Images.shared.images[index] = image
                    }
                }
            }
        }
    }
    
    // MARK: - Private methods
    func hideCell() {
        characterImage.isHidden = true
        characterLabel.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func showCell(_ character: RMCharacter, _ image: UIImage) {
        self.characterImage.image = image
        self.characterLabel.text = character.name
        
        self.activityIndicator.stopAnimating()
        self.characterImage.isHidden = false
        self.characterLabel.isHidden = false
    }
}

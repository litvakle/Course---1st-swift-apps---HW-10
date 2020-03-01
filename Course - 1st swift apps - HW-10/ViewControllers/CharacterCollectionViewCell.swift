//
//  CharacterCollectionViewCell.swift
//  Course - 1st swift apps - HW-10
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
        characterImage.isHidden = true
        characterLabel.isHidden = true
        activityIndicator.startAnimating()
        
        DispatchQueue.global().async {
            guard let stringURL = character.image else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.characterImage.image = UIImage(data: imageData)
                self.characterLabel.text = character.name
                self.characterImage.isHidden = false
                self.characterLabel.isHidden = false
            }
        }
    }
}

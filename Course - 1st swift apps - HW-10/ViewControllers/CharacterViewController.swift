//
//  CharacterViewController.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 29.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: ImageView!
    @IBOutlet weak var characterInfoLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public properties
    var character: RMCharacter!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterImageView.layer.cornerRadius = 10
        
        updateView()
    }
    
    // MARK: - Private methods
    private func updateView() {
        activityIndicator.startAnimating()
        characterNameLabel.text = character.name
        characterInfoLabel.text = character.description
        
        characterImageView.getImage(from: character.image ?? "") {
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEpisodes" {
            let etvc = segue.destination as! EpisodesTableViewController
            etvc.character = character
        }
    }
}

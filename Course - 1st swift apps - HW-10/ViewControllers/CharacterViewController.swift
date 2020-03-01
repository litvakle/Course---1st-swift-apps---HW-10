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
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterInfoLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public properties
    var character: RMCharacter!
    
    // MARK: - Override methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterImageView.layer.cornerRadius = 10
        activityIndicator.startAnimating()
        characterNameLabel.text = character.name
        characterInfoLabel.text = character.description
        
        DispatchQueue.global().async {
            guard let stringURL = self.character.image else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.characterImageView.image = UIImage(data: imageData)
            }
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

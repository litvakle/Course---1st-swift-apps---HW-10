//
//  SettingsViewController.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 09.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet weak var charactersLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var imagesLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    // MARK: - Private methods
    private func updateView() {
        let charactersCount = DataManager.shared.getCharactersFromUserDefaults().count
        let episodesCount = DataManager.shared.getEpisodesFromUserDefaults().count
        let imagesCount = DataManager.shared.getCharacterImagesFromUserDefaults().count
        
        charactersLabel.text = "Characters saved: \(charactersCount)"
        episodesLabel.text = "Episodes saved: \(episodesCount)"
        imagesLabel.text = "Images saved: \(imagesCount)"
    }
    
    private func startProcess() {
        activityIndicator.startAnimating()
        navigationItem.hidesBackButton = true
    }
    
    private func stopProcess() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.navigationItem.hidesBackButton = false
            self.updateView()
        }
    }
    
    // MARK: - IB Actions
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0: DataManager.shared.clearCharactersInUserDefaults()
        case 1: DataManager.shared.clearEpisodesInUserDefaults()
        case 2: DataManager.shared.clearImagesInUserDefaults()
        default: break
        }
        
        updateView()
    }
    
    @IBAction func loadButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            startProcess()
            Characters.shared.getCharacters(from: DataURL.shared.characters) {
                self.stopProcess()
            }
        case 1:
            startProcess()
            Episodes.shared.getEpisodes(from: DataURL.shared.episodes) {
                self.stopProcess()
            }
        case 2:
            startProcess()
            saveAllCharacterImagesToUserDefaults() {
                self.stopProcess()
            }
        default: break
        }
    }
}

// MARK: - Extension + SettingsViewController

extension SettingsViewController {
    private func saveAllCharacterImagesToUserDefaults(completion: @escaping () -> Void) {
        guard let character = DataManager.shared.getFirstUnsavedCharacterImage() else { completion(); return }
        
        let urlString = character.image ?? ""
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let imageData = data {
                if let image = UIImage(data: imageData) {
                    DataManager.shared.saveCharacterImageToUserDefaults(url: urlString, image: image)
                    DispatchQueue.main.async {
                        self.updateView()
                    }
                    self.saveAllCharacterImagesToUserDefaults(completion: completion)
                }
            }
        }.resume()
    }
}

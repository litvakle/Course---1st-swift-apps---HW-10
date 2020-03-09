//
//  DataManager.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 09.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    private let charactersKey = "Characters"
    private let episodesKey = "Episodes"
    private let characterImagesKey = "CharacterImages"
    
    // MARK: - Common methods
    func loadData(completion: @escaping () -> Void) {
        let characters = self.getCharactersFromUserDefaults()
        let episodes = self.getEpisodesFromUserDefaults()
        
        Characters.shared.getCharactersInfo(from: DataURL.shared.characters) { charactersCount in
            Episodes.shared.getEpisodesInfo(from: DataURL.shared.episodes) { episodesCount in
                if charactersCount != characters.count || episodesCount != episodes.count {
                    Characters.shared.getCharacters(from: DataURL.shared.characters) {
                        self.saveCharactersToUserDefaults(characters: Characters.shared.list)
                        Episodes.shared.getEpisodes(from: DataURL.shared.episodes) {
                            self.saveEpisodesToUserDefaults(episodes: Episodes.shared.list)
                            completion()
                        }
                    }
                } else {
                    Characters.shared.list = characters
                    Episodes.shared.list = episodes
                    completion()
                }
            }
        }
    }
    
    // MARK: - Characters
    func getCharactersFromUserDefaults() -> [RMCharacter] {
        guard let data = userDefaults.value(forKey: charactersKey) as? Data else { return [] }
        guard let characters = try? JSONDecoder().decode([RMCharacter].self, from: data) else { return [] }
        
        return characters
    }
    
    func saveCharactersToUserDefaults(characters: [RMCharacter]) {
        if let data = try? JSONEncoder().encode(characters){
            userDefaults.set(data, forKey: charactersKey)
        }
    }
    
    // MARK: - Character images
    func getCharacterImagesFromUserDefaults() -> [String: Data?] {
        if let images = userDefaults.value(forKey: characterImagesKey) as? [String: Data?] {
            return images
        }
        
        return [:]
    }
    
    func saveCharacterImageToUserDefaults(url: String, image: UIImage?) {
        guard var imagesData = getCharacterImagesFromUserDefaults() as? [String: Data] else { return }
        imagesData[url] = image?.pngData()
        userDefaults.set(imagesData, forKey: characterImagesKey)
    }
    
    // MARK: - Episodes
    func getEpisodesFromUserDefaults() -> [Episode] {
        guard let data = userDefaults.value(forKey: episodesKey) as? Data else { return [] }
        guard let episodes = try? JSONDecoder().decode([Episode].self, from: data) else { return [] }
        
        return episodes
    }
    
    func saveEpisodesToUserDefaults(episodes: [Episode]) {
        if let data = try? JSONEncoder().encode(episodes) {
            userDefaults.set(data, forKey: episodesKey)
        }
    }
}

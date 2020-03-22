//
//  UserDefaultsDataManager.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 09.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import Foundation
import UIKit

class UserDefaultsDataManager: DataManagerable {
    
    let charactersKey = DataManagerKeys.charactersKey.rawValue
    var episodesKey = DataManagerKeys.episodesKey.rawValue
    var characterImagesKey = DataManagerKeys.characterImagesKey.rawValue
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Characters
    func getCharacters() -> [RMCharacter] {
        guard let data = userDefaults.value(forKey: charactersKey) as? Data else { return [] }
        guard let characters = try? JSONDecoder().decode([RMCharacter].self, from: data) else { return [] }
        
        return characters
    }
    
    func saveCharacters(characters: [RMCharacter]) {
        guard let data = try? JSONEncoder().encode(characters) else { return }
        
        userDefaults.set(data, forKey: charactersKey)
    }
    
    func clearCharacters() {
        userDefaults.removeObject(forKey: charactersKey)
    }

    // MARK: - Character images
    func getCharacterImages() -> [String: Data] {
        if let images = userDefaults.value(forKey: characterImagesKey) as? [String: Data] {
            return images
        }
        
        return [:]
    }
    
    func saveCharacterImage(url: String, image: UIImage?) {
        var imagesData = getCharacterImages()
        imagesData[url] = image == nil ? nil : image?.pngData()
        userDefaults.set(imagesData, forKey: characterImagesKey)
    }
    
    func clearImages() {
        userDefaults.removeObject(forKey: characterImagesKey)
    }
    
    func getFirstUnsavedCharacterImage() -> RMCharacter? {
        let images = getCharacterImages()
        var character: RMCharacter? = nil
        
        for currentCharacter in getCharacters() {
            let urlString = currentCharacter.image ?? ""
            if images[urlString] == nil {
                character = currentCharacter
                break
            }
        }
        
        return character
    }
    
    // MARK: - Episodes
    func getEpisodes() -> [Episode] {
        guard let data = userDefaults.value(forKey: episodesKey) as? Data else { return [] }
        guard let episodes = try? JSONDecoder().decode([Episode].self, from: data) else { return [] }
        
        return episodes
    }
    
    func saveEpisodes(episodes: [Episode]) {
        if let data = try? JSONEncoder().encode(episodes) {
            userDefaults.set(data, forKey: episodesKey)
        }
    }
    
    func clearEpisodes() {
        userDefaults.removeObject(forKey: episodesKey)
    }
}

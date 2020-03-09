//
//  PlistFileDataManager.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 09.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import Foundation
import UIKit

class PlistFileDataManager: DataManagerable {
    
    var charactersKey: String
    var episodesKey: String
    var characterImagesKey: String
    
    private let documentsDirectory =
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let charactersURL: URL!
    private let episodesURL: URL!
    private let characterImagesURL: URL!
    
    required init(charactersKey: String, episodesKey: String, characterImagesKey: String) {
        self.charactersKey = charactersKey
        self.episodesKey = episodesKey
        self.characterImagesKey = characterImagesKey
        
        charactersURL = documentsDirectory.appendingPathComponent(charactersKey).appendingPathExtension("plist")
        episodesURL = documentsDirectory.appendingPathComponent(episodesKey).appendingPathExtension("plist")
        characterImagesURL = documentsDirectory.appendingPathComponent(characterImagesKey).appendingPathExtension("plist")
    }
    
    // MARK: - Characters
    func getCharacters() -> [RMCharacter] {
        guard let data = try? Data(contentsOf: charactersURL) else { return [] }
        guard let characters = try? PropertyListDecoder().decode([RMCharacter].self, from: data) else { return [] }
        
        return characters
    }
    
    func saveCharacters(characters: [RMCharacter]) {
        guard let data = try? PropertyListEncoder().encode(characters) else { return }
        try? data.write(to: charactersURL, options: .noFileProtection)
    }
    
    func clearCharacters() {
        saveCharacters(characters: [RMCharacter]())
    }

    // MARK: - Character images
    func getCharacterImages() -> [String: Data?] {
        guard let data = try? Data(contentsOf: characterImagesURL) else { return [:] }
        guard let images = try? PropertyListDecoder().decode([String: Data?].self, from: data) else { return [:] }
        
        return images
    }
    
    func saveCharacterImage(url: String, image: UIImage?) {
        guard var imagesData = getCharacterImages() as? [String: Data] else { return }
        imagesData[url] = image?.pngData()
        
        guard let data = try? PropertyListEncoder().encode(imagesData) else { return }
        try? data.write(to: characterImagesURL, options: .noFileProtection)
    }
    
    func clearImages() {
        let emptyDict = [String: Data]()
        guard let data = try? PropertyListEncoder().encode(emptyDict) else { return }
        try? data.write(to: characterImagesURL, options: .noFileProtection)
    }
    
    // MARK: - Episodes
    func getEpisodes() -> [Episode] {
        guard let data = try? Data(contentsOf: episodesURL) else { return [] }
        guard let episodes = try? PropertyListDecoder().decode([Episode].self, from: data) else { return [] }
        
        return episodes
    }
    
    func saveEpisodes(episodes: [Episode]) {
        guard let data = try? PropertyListEncoder().encode(episodes) else { return }
        try? data.write(to: episodesURL, options: .noFileProtection)
    }
    
    func clearEpisodes() {
        saveEpisodes(episodes: [Episode]())
    }
}

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
    
    private let charactersKey = "Characters"
    private let episodesKey = "Episodes"
    private let characterImagesKey = "CharacterImages"
    
    let manager: DataManagerable
    
    init() {
        manager = UserDefaultsDataManager(charactersKey: charactersKey,
                                          episodesKey: episodesKey,
                                          characterImagesKey: characterImagesKey)
//        manager = PlistFileDataManager(charactersKey: charactersKey,
//                                       episodesKey: episodesKey,
//                                       characterImagesKey: characterImagesKey)
    }

    func loadData(completion: @escaping () -> Void) {
        let characters = self.manager.getCharacters()
        let episodes = self.manager.getEpisodes()
        
        Characters.shared.getCharactersInfo(from: DataURL.shared.characters) { charactersCount in
            Episodes.shared.getEpisodesInfo(from: DataURL.shared.episodes) { episodesCount in
                if charactersCount != characters.count || episodesCount != episodes.count {
                    Characters.shared.getCharacters(from: DataURL.shared.characters) {
                        Episodes.shared.getEpisodes(from: DataURL.shared.episodes) {
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
    
    func getFirstUnsavedCharacterImage() -> RMCharacter? {
        let images = manager.getCharacterImages()
        var character: RMCharacter? = nil
        
        for currentCharacter in manager.getCharacters() {
            let urlString = currentCharacter.image ?? ""
            if images[urlString] == nil {
                character = currentCharacter
                break
            }
        }
        
        return character
    }
}

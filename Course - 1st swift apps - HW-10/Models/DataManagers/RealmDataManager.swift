//
//  RealmDataManager.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 15.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class RealmDataManager: DataManagerable {

    func deleteConfiguration() {
        let _ = try? Realm.deleteFiles(for: realm.configuration)
    }
    
    // MARK: - Characters
    func getCharacters() -> [RMCharacter] {
        guard let data = realm.objects(RealmCharacters.self).first?.characters else { return [] }
        guard let characters = try? JSONDecoder().decode([RMCharacter].self, from: data) else { return [] }
        
        return characters
    }
    
    func saveCharacters(characters: [RMCharacter]) {
        guard let data = try? JSONEncoder().encode(characters) else { return }
        let realmCharacters = realm.objects(RealmCharacters.self).first ?? RealmCharacters()
        
        try! realm.write {
            realmCharacters.characters = data
            
            if realm.objects(RealmCharacters.self).count == 0 {
                realm.add(realmCharacters)
            }
        }
    }
    
    func clearCharacters() {
        saveCharacters(characters: [])
    }
    
    // MARK: - Character images
    func getCharacterImages() -> [String : Data] {
        guard let data = realm.objects(RealmCharacterImages.self).first?.images else { return [:] }
        guard let result = try? JSONDecoder().decode([String:Data].self, from: data) else { return [:] }

        return result
    }
    
    func saveCharacterImage(url: String, image: UIImage?) {
        var characterImages = getCharacterImages()
        characterImages[url] = image?.pngData()
        guard let data = try? JSONEncoder().encode(characterImages) else { return }

        let realmCharacterImages = realm.objects(RealmCharacterImages.self).first ?? RealmCharacterImages()
        DispatchQueue.main.async {
            try! realm.write {
                realmCharacterImages.images = data
                
                if realm.objects(RealmCharacterImages.self).count == 0 {
                    realm.add(realmCharacterImages)
                }
            }
        }
    }
    
    func clearImages() {
        guard realm.objects(RealmCharacterImages.self).count > 0 else { return }
        let realmCharacterImages = realm.objects(RealmCharacterImages.self).first
        let emptyDict = [String: Data]()
        guard let emptyData = try? JSONEncoder().encode(emptyDict) else { return }

        try! realm.write {
            realmCharacterImages?.images = emptyData
        }
    }
    
    // MARK: - Episodes
    func getEpisodes() -> [Episode] {
        guard let data = realm.objects(RealmEpisodes.self).first?.episodes else { return [] }
        guard let episodes = try? JSONDecoder().decode([Episode].self, from: data) else { return [] }
        
        return episodes
    }
    
    func saveEpisodes(episodes: [Episode]) {
        guard let data = try? JSONEncoder().encode(episodes) else { return }
        let realmEpisodes = realm.objects(RealmEpisodes.self).first ?? RealmEpisodes()
        
        try! realm.write {
            realmEpisodes.episodes = data
            
            if realm.objects(RealmEpisodes.self).count == 0 {
                realm.add(realmEpisodes)
            }
        }
    }
    
    func clearEpisodes() {
        saveEpisodes(episodes: [])
    }
}

class RealmCharacters: Object {
    @objc dynamic var characters = Data()
}

class RealmEpisodes: Object {
    @objc dynamic var episodes = Data()
}

class RealmCharacterImages: Object {
    @objc dynamic var images = Data()
}

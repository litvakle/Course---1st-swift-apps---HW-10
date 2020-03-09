//
//  Characters.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 29.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

class Characters {
    static var shared = Characters()
    
    var list = [RMCharacter]()
    
    func getCharactersInfo(from url: String, completion: @escaping (Int) -> Void) {
        JSONParser.shared.parseJSONwithAlamofire(from: url, to: CharactersData.self) { data in
            if let jsonData = data as? CharactersData {
                completion(jsonData.info?.count ?? 0)
            }
        }
    }
    
    func getCharacters(from url: String, clearList: Bool = true, completion: @escaping () -> Void) {
        if clearList { list.removeAll() }

        if url == "" {
            DataManager.shared.saveCharactersToUserDefaults(characters: list)
            completion()
        } else {
            JSONParser.shared.parseJSONwithAlamofire(from: url, to: CharactersData.self) { data in
                if let jsonData = data as? CharactersData, let jsonCharacters = jsonData.results {
                    self.list += jsonCharacters
                    self.getCharacters(from: jsonData.info?.next ?? "",
                                       clearList: false,
                                       completion: completion)
                }
            }
        }
    }
}

// MARK: - JSON Struct
struct CharactersData: Codable {
    let info: Info?
    let results: [RMCharacter]?
}

struct RMCharacter: Codable { // добавил "RM", чтобы не совпало с название предопределённого типа Character
    let id: Int
    let species: String?
    let origin: Origin?
    let location: Location?
    let image: String?
    let episode: [String]?
    let name: String?
    let gender: String?
    let status: String?
    
    var description: String {
        return """
        Gender: \(gender ?? "unknown")
        Status: \(status ?? "unknown")
        Species: \(species ?? "unknown")
        Origin: \(origin?.name ?? "unknown")
        Location: \(location?.name ?? "unknown")
        """
    }
}

struct Origin: Codable {
    let name: String?
}

struct Location: Codable {
    let name: String?
}

struct Info: Codable {
    let next: String?
    let count: Int?
}

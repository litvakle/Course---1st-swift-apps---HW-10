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
    
    func getCharacters(from url: String, completion: @escaping () -> Void) {
        // Рекурсия до тех пор, пока не дойдём до последнего файла
        if url == "" { completion() }
        
        JSONParser.shared.parseJSON(from: url, to: CharactersData.self) { (data, info) in
            if let jsonData = data as? CharactersData, let jsonCharacters = jsonData.results {
                self.list += jsonCharacters
                self.getCharacters(from: jsonData.info?.next ?? "", completion: completion)
            }
        }
    }
}

// MARK: - JSON Struct
struct CharactersData: Decodable {
    var info: Info? = nil
    var results: [RMCharacter]? = nil
}

struct RMCharacter: Decodable { // добавил "RM", чтобы не совпало с название предопределённого типа Character
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

struct Origin: Decodable {
    let name: String?
}

struct Location: Decodable {
    let name: String?
}

struct Info: Decodable {
    let next: String?
}

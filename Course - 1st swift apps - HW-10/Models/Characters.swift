//
//  Characters.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 29.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class Characters {
    var list = [RMCharacter]()
    
    func getCharacters(from url: String, completion: @escaping ()->Void) {
        if url == "" {
            completion()
        }
        
        JSONParser.shared.parseJSON(from: url, to: RMData.self) { (data, info) in
            if let jsonData = data as? RMData, let jsonCharacters = jsonData.results {
                self.list += jsonCharacters
                self.getCharacters(from: jsonData.info?.next ?? "", completion: completion)
            }
        }
    }
}

struct RMData: Decodable {
    var info: Info? = nil
    var results: [RMCharacter]? = nil
}

struct RMCharacter: Decodable {
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
    let url: String?
}

struct Location: Decodable {
    let name: String?
    let url: String?
}

struct Info: Decodable {
    let next: String?
    let prev: String?
}

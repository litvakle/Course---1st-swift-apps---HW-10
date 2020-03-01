//
//  Episodes.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 01.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

class Episodes {
    static var shared = Episodes()
    
    var list = [Episode]()
    
    func getEpisodes(from url: String, completion: @escaping ()->Void) {
        JSONParser.shared.parseJSON(from: url, to: EpisodesData.self) { (data, info) in
            if let jsonData = data as? EpisodesData, let jsonEpisodes = jsonData.results {
                self.list += jsonEpisodes
            }
        }
    }
}

// MARK: - JSON Struct
struct EpisodesData: Decodable {
    let results: [Episode]?
}

struct Episode: Decodable {
    let name: String?
    let air_date: String?
    let episode: String?
}

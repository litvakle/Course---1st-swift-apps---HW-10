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
    
    func getEpisode(by url: String) -> Episode? {
        return list.filter { $0.url == url }.first
    }
    
    func getEpisodes(from url: String, completion: @escaping () -> Void) {
        if url == "" { completion() }
        
        JSONParser.shared.parseJSON(from: url, to: EpisodesData.self) { (data, info) in
            if let jsonData = data as? EpisodesData, let jsonEpisodes = jsonData.results {
                self.list += jsonEpisodes
                self.getEpisodes(from: jsonData.info?.next ?? "", completion: completion)
            }
        }
    }
}

// MARK: - JSON Struct
struct EpisodesData: Decodable {
    let results: [Episode]?
    let info: EpisodesInfo?
}

struct Episode: Decodable {
    let name: String?
    let air_date: String?
    let episode: String?
    let url: String?
}

struct EpisodesInfo: Decodable {
    let next: String?
}

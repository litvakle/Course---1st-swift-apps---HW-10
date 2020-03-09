//
//  Episodes.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 01.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

class Episodes {
    static let shared = Episodes()
    
    var list = [Episode]()
    
    func getEpisode(by url: String) -> Episode? {
        return list.filter { $0.url == url }.first
    }
    
    func getEpisodesInfo(from url: String, completion: @escaping (Int) -> Void) {
        JSONParser.shared.parseJSONwithAlamofire(from: url, to: EpisodesData.self) { data in
            if let jsonData = data as? EpisodesData {
                completion(jsonData.info?.count ?? 0)
            }
        }
    }
    
    func getEpisodes(from url: String, completion: @escaping () -> Void) {
        // В каждом файле есть ссылка на файл со следующей порцией эпизодов
        // Рекурсия до тех пор, пока не дойдём до последнего файла
        if url == "" { completion() } else {
            //        JSONParser.shared.parseJSON(from: url, to: EpisodesData.self) { data in
            //            if let jsonData = data as? EpisodesData, let jsonEpisodes = jsonData.results {
            //                self.list += jsonEpisodes
            //                self.getEpisodes(from: jsonData.info?.next ?? "", completion: completion)
            //            }
            //        }
            JSONParser.shared.parseJSONwithAlamofire(from: url, to: EpisodesData.self) { data in
                if let jsonData = data as? EpisodesData, let jsonEpisodes = jsonData.results {
                    self.list += jsonEpisodes
                    self.getEpisodes(from: jsonData.info?.next ?? "", completion: completion)
                }
            }
        }
    }
}

// MARK: - JSON Struct
struct EpisodesData: Codable {
    let results: [Episode]?
    let info: EpisodesInfo?
}

struct Episode: Codable {
    let name: String?
    let air_date: String?
    let episode: String?
    let url: String?
}

struct EpisodesInfo: Codable {
    let next: String?
    let count: Int?
}

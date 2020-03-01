//
//  NetworkManager.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 29.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import Foundation

class JSONParser {
    static let shared = JSONParser()
    
    typealias CompletionHandler<T> = (_ data: T?, _ info: String) -> Void
    
    func parseJSON<T>(from url: String, to type: T.Type, completionHandler: @escaping CompletionHandler<Any>) where T: Decodable {
        
        guard let url = URL(string: url) else {
            completionHandler(nil, "Address is not valid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(type, from: data) //
                completionHandler(result, "Success")
            } catch {
                completionHandler(nil,"Decoding error: \(error)")
            }
        }.resume()
    }
}

class DataURL {
    static let shared = DataURL()
    
    let characters = "https://rickandmortyapi.com/api/character/"
    let episodes = "https://rickandmortyapi.com/api/episode/"
}

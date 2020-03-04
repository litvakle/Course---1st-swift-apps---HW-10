//
//  NetworkManager.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 29.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import Foundation
import Alamofire

class JSONParser {
    static let shared = JSONParser()
    
    typealias CompletionHandler<T> = (_ data: T?) -> Void
    
    func parseJSON<T>(from url: String, to type: T.Type, completionHandler: @escaping CompletionHandler<Any>) where T: Decodable {
        
        guard let url = URL(string: url) else {
            print("Address is not valid URL")
            completionHandler(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(type, from: data) //
                completionHandler(result)
            } catch {
                print("Decoding error: \(error)")
                completionHandler(nil)
            }
        }.resume()
    }
    
    func parseJSONwithAlamofire<T>(from url: String, to type: T.Type, completion: @escaping CompletionHandler<Any>) where T: Decodable{
        AF .request(url).validate().responseDecodable(of: type) { dataResponce in
            switch dataResponce.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
}

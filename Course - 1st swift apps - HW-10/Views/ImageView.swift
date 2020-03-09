//
//  ImageView.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 07.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class ImageView: UIImageView {

    var currentTask: URLSessionTask?
    
    func getImage(from url: String) {
        image = nil
        
        weak var oldTask = currentTask
        currentTask = nil
        oldTask?.cancel()
        
        guard let url = URL(string: url) else { return }

        if let cachedImage = getImageFromCache(url: url) {
            image = cachedImage
            return
        }

        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data, let response = response else { print("no data/response"); return }
            guard let responseURL = response.url else { return }
            guard url.absoluteString == responseURL.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                self.saveImageToCache(data: data, response: response)
            }
        }
        
        currentTask = dataTask
        currentTask?.resume()
    }

    func getImageFromCache(url: URL) -> UIImage? {
        guard let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) else {
            return nil
        }

        let image = UIImage(data: cachedResponse.data)

        return image
    }

    func saveImageToCache(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}

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
    
    func getImage(from urlString: String, completion: @escaping () -> Void) {
        image = nil
        
        weak var oldTask = currentTask
        currentTask = nil
        
        guard let url = URL(string: urlString) else { return }

//        if let cachedImage = ImageManager.shared.getImageFromCache(url: url) {
        if let cachedImage = ImageManager.shared.getImageFromStorage(url: urlString) {
            image = cachedImage
            completion()
            return
        }

        oldTask?.cancel()
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data, let response = response else { print("no data/response"); return }
            guard let responseURL = response.url else { return }
            guard url.absoluteString == responseURL.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                //self.saveImageToCache(data: data, response: response)
                DataManager.shared.manager.saveCharacterImage(url: urlString, image: self.image)
                completion()
            }
        }
        
        currentTask = dataTask
        currentTask?.resume()
    }
}

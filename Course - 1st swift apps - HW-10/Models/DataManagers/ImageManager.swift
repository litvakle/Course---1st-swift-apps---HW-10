//
//  ImageManager.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 09.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import Foundation
import UIKit

class ImageManager {
    static let shared = ImageManager()
    
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
    
    func getImageFromStorage(url: String) -> UIImage? {
        guard let imagesData = DataManager.shared.manager.getCharacterImages() as? [String: Data] else { return nil }
        guard let imageData = imagesData[url] else { return nil }
        
        return UIImage(data: imageData)
    }
}

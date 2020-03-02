//
//  Images.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 02.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class Images {
    static let shared = Images()
    
    var images = [Int: UIImage]()
    
    func getImageData(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        
        return try? Data(contentsOf: imageURL) 
    }
}

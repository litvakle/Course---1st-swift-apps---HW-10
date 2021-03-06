//
//  DataManagerable.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 09.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import Foundation
import UIKit

protocol DataManagerable {
    
    func getCharacters() -> [RMCharacter]
    func saveCharacters(characters: [RMCharacter])
    func clearCharacters()
    
    func getCharacterImages() -> [String: Data]
    func saveCharacterImage(url: String, image: UIImage?)
    func clearImages()
    
    func getEpisodes() -> [Episode]
    func saveEpisodes(episodes: [Episode])
    func clearEpisodes()
}

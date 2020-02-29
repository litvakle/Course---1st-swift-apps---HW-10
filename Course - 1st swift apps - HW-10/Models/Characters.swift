//
//  Characters.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 29.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

struct Origin: Decodable {
    let name: String?
    let url: String?
}

struct Location: Decodable {
    let name: String?
    let url: String?
}

struct RMCharacter: Decodable {
    let species: String?
    let origin: Origin?
    let location: Location?
    let image: String?
    let episode: [String]?
    let name: String?
    let gender: String?
    let status: String?
}

struct Info: Decodable {
    let next: String?
    let prev: String?
}

struct Characters: Decodable {
    let info: Info?
    let results: [RMCharacter]?
}



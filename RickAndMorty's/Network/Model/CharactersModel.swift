//
//  CharactersModel.swift
//  RickAndMorty's
//
//  Created by Макар Тюрморезов on 26.01.2023.
//

import Foundation

struct CharactersModel: Decodable {
    
    var results: [CharacterSet]?
    
}

struct CharacterSet: Decodable {
    
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: Origin
    var image: String?
    var location: Location
}
struct Location: Decodable {
    
    var name: String?
    var url: String?
    
}
struct Origin: Decodable {
    var name: String?
    var url: String?
}


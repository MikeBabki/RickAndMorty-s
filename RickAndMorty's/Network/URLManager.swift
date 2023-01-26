//
//  URLManager.swift
//  RickAndMorty's
//
//  Created by Макар Тюрморезов on 26.01.2023.
//

import Foundation

class URLManager {
    
    static let urlString = "https://rickandmortyapi.com/api/character/?page=19"
    
    static func rickURLCreator(page: Int) -> String {
       return urlString + "/character/?page=\(page)"
    }
}

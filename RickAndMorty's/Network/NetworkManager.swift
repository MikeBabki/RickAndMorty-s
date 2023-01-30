//
//  NetworkManager.swift
//  RickAndMorty's
//
//  Created by Макар Тюрморезов on 26.01.2023.
//

import Foundation

class NetworkManager {
    
    func getResult(page: Int, completion: @escaping(Result<CharactersModel?, Error>) -> Void) {
        let url = URL(string: URLManager.rickURLCreator(page: page))
        URLSession.shared.dataTask(with: url!) { data, _, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            do {
                let result = try JSONDecoder().decode(CharactersModel.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

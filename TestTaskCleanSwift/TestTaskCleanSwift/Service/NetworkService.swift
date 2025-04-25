//
//  NetworkService.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count, pages: Int
    let next: String
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}

class NetworkService {
    
    static let shared = NetworkService()
    
    func fetchData(completion: @escaping (Result<[Character], Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character"
        
        guard let url = URL(string: urlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let responseError = error {
                completion(.failure(responseError))
                print("Error: \(responseError)")
            }
            
            guard let responseData = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let characterResponse = try decoder.decode(CharacterResponse.self, from: responseData)
                completion(.success(characterResponse.results))
            } catch {
                completion(.failure(error))
            }
           
            
        }.resume()
        
    }
}

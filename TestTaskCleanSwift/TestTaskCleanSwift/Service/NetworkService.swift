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
    let imageURL: String?
    let imageData: Data?
    
    init(id: Int, name: String, status: String, species: String, gender: String, imageURL: String? = nil, imageData: Data? = nil) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.imageURL = imageURL
        self.imageData = imageData
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case imageURL = "image"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(String.self, forKey: .status)
        species = try container.decode(String.self, forKey: .species)
        gender = try container.decode(String.self, forKey: .gender)
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        imageData = nil
    }
}

class NetworkService {
    
    static let shared = NetworkService()
    
    func fetchData(urlString: String ,completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let responseError = error {
                completion(.failure(responseError))
                print("Error: \(responseError)")
            }
            
            guard let responseData = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let characterResponse = try decoder.decode(CharacterResponse.self, from: responseData)
                completion(.success(characterResponse))
            } catch {
                completion(.failure(error))
            }
            
            
        }.resume()
        
    }
}

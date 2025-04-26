//
//  CharacterListWorker.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

class CharacterListWorker
{
    
    func fetchNetworkCharacter(urlString: String?, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        let defaultString = "https://rickandmortyapi.com/api/character"
        let finalUrl = urlString ?? defaultString
        
        NetworkService.shared.fetchData(urlString: finalUrl) { result in
            completion(result)
        }
    }
}

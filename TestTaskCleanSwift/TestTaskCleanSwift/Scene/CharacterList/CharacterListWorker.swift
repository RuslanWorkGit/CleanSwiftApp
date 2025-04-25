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
//    func fetchCharacters() -> [CharacterList.Character] {
//        return [
//            CharacterList.Character(name: "Tommy"),
//            CharacterList.Character(name: "Bommy"),
//            CharacterList.Character(name: "Nommy"),
//            CharacterList.Character(name: "Kommy"),
//            CharacterList.Character(name: "Lommy")
//        ]
//    }
    
    func fetchNetworkCharacter(completion: @escaping (Result<[Character], Error>) -> Void) {
        NetworkService.shared.fetchData { result in
            completion(result)
        }
    }
}

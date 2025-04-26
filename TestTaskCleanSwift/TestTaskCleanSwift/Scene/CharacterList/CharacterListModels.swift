//
//  CharacterListModels.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

enum CharacterList
{
    // MARK: Use cases
//    struct Character {
//        let name: String
//    }
    
    struct CharacterDisplay {
        let name: String
        let image: String
    }
    
    
    
    enum FetchCharacter {
        struct Request {
        }
        struct Response {
            let characters: [Character]
        }
        struct ViewModel {
            let displayCharacter: [CharacterDisplay]
        }
    }
}

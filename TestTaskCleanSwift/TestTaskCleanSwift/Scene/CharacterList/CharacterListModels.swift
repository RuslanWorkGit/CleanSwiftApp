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
        let id: Int
        let name: String
        let status: String
        let species: String
        let gender: String
        let imageURL: String?
        let imageData: Data?
    }
    
    
    
    enum FetchCharacter {
        struct Request {
            var urlString: String?
        }
        struct Response {
            let characters: [Character]
        }
        struct ViewModel {
            let displayCharacter: [CharacterDisplay]
        }
    }
}

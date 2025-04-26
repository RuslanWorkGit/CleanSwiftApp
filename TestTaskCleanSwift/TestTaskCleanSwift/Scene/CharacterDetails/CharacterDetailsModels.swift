//
//  CharacterDetailsModels.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum CharacterDetails
{
    // MARK: Use cases
    
    struct CharacterDisplay {
        let name: String
        let status: String
        let species: String
        let gender: String
        let imageUrl: String
    }
    
    enum FetchCharacter
    {
        struct Request
        {
        }
        struct Response
        {
            let character: CharacterDisplay
        }
        struct ViewModel
        {
            let name: String
            let status: String
            let species: String
            let gender: String
            let imageUrl: String
        }
    }
}

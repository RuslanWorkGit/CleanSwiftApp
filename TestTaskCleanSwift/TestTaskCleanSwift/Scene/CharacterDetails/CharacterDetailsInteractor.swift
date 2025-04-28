//
//  CharacterDetailsInteractor.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CharacterDetailsBusinessLogic
{
    func fetchCharacterDetails(request: CharacterDetails.FetchCharacter.Request)
}

protocol CharacterDetailsDataStore
{
    var character: CharacterDetails.CharacterDisplay? { get set }
}

class CharacterDetailsInteractor: CharacterDetailsBusinessLogic, CharacterDetailsDataStore
{
    
    
    var presenter: CharacterDetailsPresentationLogic?
    var worker: CharacterDetailsWorker?
    
    var character: CharacterDetails.CharacterDisplay?
    

    func fetchCharacterDetails(request: CharacterDetails.FetchCharacter.Request)
    {
        guard let character = character else { return }
        
        let response = CharacterDetails.FetchCharacter.Response(character: character)
        presenter?.presentCharacterDetails(response: response)
    }
}

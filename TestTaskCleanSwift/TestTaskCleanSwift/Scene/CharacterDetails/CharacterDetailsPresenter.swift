//
//  CharacterDetailsPresenter.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol CharacterDetailsPresentationLogic
{
    func presentCharacterDetails(response: CharacterDetails.FetchCharacter.Response)
}

class CharacterDetailsPresenter: CharacterDetailsPresentationLogic
{
    weak var viewController: CharacterDetailsDisplayLogic?
    
    func presentCharacterDetails(response: CharacterDetails.FetchCharacter.Response)
    {
        
        let viewModel = CharacterDetails.FetchCharacter.ViewModel(
            name: response.character.name,
            status: response.character.status,
            species: response.character.species,
            gender: response.character.gender,
            image: response.character.image
        )
        
        //print(viewModel)
        viewController?.displayCharacterDetails(viewModel: viewModel)
    }
}

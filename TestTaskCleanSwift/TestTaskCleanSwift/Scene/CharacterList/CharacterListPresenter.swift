//
//  CharacterListPresenter.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol CharacterListPresentationLogic
{
    func presentCharacters(response: CharacterList.FetchCharacter.Response)
}

class CharacterListPresenter: CharacterListPresentationLogic
{
    weak var viewController: CharacterListDisplayLogic?

    
    func presentCharacters(response: CharacterList.FetchCharacter.Response)
    {

        
        let rows = response.characters.map { character in
            
            return CharacterList.CharacterDisplay(id: character.id, name: character.name, status: character.status, species: character.species, gender: character.gender, imageURL: character.imageURL, imageData: character.imageData)
            
        }
        
        let viewModel = CharacterList.FetchCharacter.ViewModel(displayCharacter: rows)
        viewController?.displayCharacter(viewModel: viewModel)
    }
}

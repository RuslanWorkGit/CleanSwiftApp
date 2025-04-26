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
    
    // MARK: Do something
    
    func presentCharacters(response: CharacterList.FetchCharacter.Response)
    {
        let rows = response.characters.map { character in
            return CharacterList.CharacterDisplay(name: character.name, image: character.image)
        }
        
        let viewModel = CharacterList.FetchCharacter.ViewModel(displayCharacter: rows)
        viewController?.displayCharacter(viewModel: viewModel)
    }
}

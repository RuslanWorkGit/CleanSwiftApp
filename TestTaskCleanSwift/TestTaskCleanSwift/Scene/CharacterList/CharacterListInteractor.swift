//
//  CharacterListInteractor.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol CharacterListBusinessLogic
{
    func doCharacters(request: CharacterList.FetchCharacter.Request)
}

protocol CharacterListDataStore
{
    var selectedCharacter: CharacterList.CharacterDisplay? { get set }
}

class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore
{
    
    var presenter: CharacterListPresentationLogic?
    var worker: CharacterListWorker?
    
    var selectedCharacter: CharacterList.CharacterDisplay?
    
    // MARK: Do something
    
    func doCharacters(request: CharacterList.FetchCharacter.Request)
    {
        worker = CharacterListWorker()

        worker?.fetchNetworkCharacter { result in
            switch result {
            case .success(let success):
                let response = CharacterList.FetchCharacter.Response(characters: success)
                self.presenter?.presentCharacters(response: response)
            case .failure(let failure):
                print("Error fetching character: \(failure)")
            }
        }
        
//        let response = CharacterList.FetchCharacter.Response(characters: characters)
//        presenter?.presentSomething(response: response)
    }
}

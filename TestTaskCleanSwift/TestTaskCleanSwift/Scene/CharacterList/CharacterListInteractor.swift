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
    var nextPageUrl: String? { get set }
}

class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore
{
    
    var presenter: CharacterListPresentationLogic?
    var worker: CharacterListWorker?
    var nextPageUrl: String?
    
    var selectedCharacter: CharacterList.CharacterDisplay?

    
    func doCharacters(request: CharacterList.FetchCharacter.Request)
    {
        worker = CharacterListWorker()
        
        if NetworkMonitor.shared.isConnected {
            
            worker?.fetchNetworkCharacter(urlString: request.urlString) { results in
                
                switch results {
                case .success(let success):
                    self.nextPageUrl = success.info.next
                    let characters = success.results
                    
                    self.worker?.saveCharacterToCoreData(characters: characters)
                    let response = CharacterList.FetchCharacter.Response(characters: characters)
                    self.presenter?.presentCharacters(response: response)
                case .failure(let failure):
                    print("Error fetching character: \(failure)")
                }
            }
        } else {
            let savedCharacters = worker?.fetchCharacterFromCoreData() ?? []
            let response = CharacterList.FetchCharacter.Response(characters: savedCharacters)
            self.presenter?.presentCharacters(response: response)
        }
    }
}

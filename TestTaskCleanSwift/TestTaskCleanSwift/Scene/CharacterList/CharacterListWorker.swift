//
//  CharacterListWorker.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit
import CoreData

class CharacterListWorker
{
    
    func fetchNetworkCharacter(urlString: String?, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        let defaultString = "https://rickandmortyapi.com/api/character"
        let finalUrl = urlString ?? defaultString
        
        NetworkService.shared.fetchData(urlString: finalUrl) { result in
            completion(result)
        }
    }
    
    func saveCharacterToCoreData(characters: [Character]) {
        let context = CoreDataService.shared.context
        
        for character in characters {
            
            let cdCharacter = CDCharacter(context: context)
            cdCharacter.id = Int64(character.id)
            cdCharacter.name = character.name
            cdCharacter.status = character.status
            cdCharacter.species = character.species
            cdCharacter.gender = character.gender
            //cdCharacter.image = character.imageData
            
            if let urlString = character.imageURL, let url = URL(string: urlString), let imageData = try? Data(contentsOf: url) {
                cdCharacter.image = imageData
            }
            
            
        }
        
        CoreDataService.shared.save(context: context)
    }
    
    func fetchCharacterFromCoreData() -> [Character] {
        let fetchRequest: NSFetchRequest<CDCharacter> = CDCharacter.fetchRequest()
        let cdCharacter = CoreDataService.shared.fetchDataFromEntity(CDCharacter.self, fetchRequest: fetchRequest)
        
        let characters = cdCharacter.map { cdCharacter in
            
            Character(
                id: Int(cdCharacter.id),
                name: cdCharacter.name ?? "",
                status: cdCharacter.status ?? "",
                species: cdCharacter.species ?? "",
                gender: cdCharacter.gender ?? "",
                imageData: cdCharacter.image
            )
        }
        
        return characters
    }
}

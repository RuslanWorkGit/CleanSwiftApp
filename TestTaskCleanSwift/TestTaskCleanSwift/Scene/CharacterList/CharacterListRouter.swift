//
//  CharacterListRouter.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CoreData

@objc protocol CharacterListRoutingLogic
{
    func routeToCharacterDetails()
}

protocol CharacterListDataPassing
{
    var dataStore: CharacterListDataStore? { get set }
}

class CharacterListRouter: NSObject, CharacterListRoutingLogic, CharacterListDataPassing
{
    
    weak var viewController: CharacterListViewController?
    var dataStore: CharacterListDataStore?
    
    //    func routToCharacterDetails() {
    //        let detailsVC = CharacterDetailsViewController()
    //        let destinationRouter = CharacterDetailsRouter()
    //        detailsVC.router = destinationRouter
    //        destinationRouter.viewController = detailsVC
    //        destinationRouter.dataStore = CharacterDetailsInteractor()
    //
    //        if var destinationDS = destinationRouter.dataStore {
    //            destinationDS.character = dataStore?.selectedCharacter
    //        }
    //
    //
    //        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    //    }
    
    func routeToCharacterDetails() {
        let destinationVC = CharacterDetailsViewController()
        let destinationInteractor = CharacterDetailsInteractor()
        let destinationPresenter = CharacterDetailsPresenter()
        let destinationRouter = CharacterDetailsRouter()
        
        destinationVC.interactor = destinationInteractor
        destinationVC.router = destinationRouter
        destinationInteractor.presenter = destinationPresenter
        destinationPresenter.viewController = destinationVC
        destinationRouter.viewController = destinationVC
        destinationRouter.dataStore = destinationInteractor
        
        if let selectedCharacter = dataStore?.selectedCharacter {
            
            var imageData: Data?
            
            if NetworkMonitor.shared.isConnected {
                if let urlString = selectedCharacter.imageURL, let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
                    imageData = data
                } else {
                    imageData = selectedCharacter.imageData
                }
            } else {
                let request: NSFetchRequest<CDCharacter> = CDCharacter.fetchRequest()
                request.predicate = NSPredicate(format: "id == %d", selectedCharacter.id)
                let saved = CoreDataService.shared.fetchDataFromEntity(CDCharacter.self, fetchRequest: request)
                imageData = saved.first?.image
                print("IMAGE DATA \(imageData)")
            }
            
            let finalImage = imageData ?? Data() //empty image
            
            let detailsCharacter = CharacterDetails.CharacterDisplay(
                name: selectedCharacter.name,
                status: selectedCharacter.status,
                species: selectedCharacter.species,
                gender: selectedCharacter.gender,
                image: finalImage
            )
            
            destinationInteractor.character = detailsCharacter
            
        }
        
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}

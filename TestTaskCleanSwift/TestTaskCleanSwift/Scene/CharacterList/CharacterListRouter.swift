//
//  CharacterListRouter.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

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
            let detailsCharacter = CharacterDetails.CharacterDisplay(
                name: selectedCharacter.name,
                status: selectedCharacter.status,
                species: selectedCharacter.species,
                gender: selectedCharacter.gender,
                imageUrl: selectedCharacter.image
            )
            destinationInteractor.character = detailsCharacter
        }
        
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: CharacterListViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: CharacterListDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}

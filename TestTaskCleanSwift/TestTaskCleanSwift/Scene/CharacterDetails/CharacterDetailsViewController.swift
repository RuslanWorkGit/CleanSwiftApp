//
//  CharacterDetailsViewController.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CharacterDetailsDisplayLogic: class
{
    func displayCharacterDetails(viewModel: CharacterDetails.FetchCharacter.ViewModel)
}

class CharacterDetailsViewController: UIViewController, CharacterDetailsDisplayLogic
{
    var interactor: CharacterDetailsBusinessLogic?
    var router: (NSObjectProtocol & CharacterDetailsRoutingLogic & CharacterDetailsDataPassing)?
    
    private let characterNameLabel = UILabel()
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = CharacterDetailsInteractor()
        let presenter = CharacterDetailsPresenter()
        let router = CharacterDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(characterNameLabel)
        
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            characterNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        doSomething()
        
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = CharacterDetails.FetchCharacter.Request()
        interactor?.fetchCharacterDetails(request: request)
    }
    
    func displayCharacterDetails(viewModel: CharacterDetails.FetchCharacter.ViewModel)
    {
        characterNameLabel.text = viewModel.name
    }
}

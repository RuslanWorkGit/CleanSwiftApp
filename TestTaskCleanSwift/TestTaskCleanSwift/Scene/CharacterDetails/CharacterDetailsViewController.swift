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
    private let characterStatusLabel = UILabel()
    private let characterSpeciesLabel = UILabel()
    private let characterGenderLabel = UILabel()
    private let characterImageView = UIImageView()
    
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
        view.addSubview(characterStatusLabel)
        view.addSubview(characterSpeciesLabel)
        view.addSubview(characterGenderLabel)
        view.addSubview(characterImageView)
        
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        characterSpeciesLabel.translatesAutoresizingMaskIntoConstraints = false
        characterGenderLabel.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        characterNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        characterImageView.layer.cornerRadius = 12
        characterImageView.clipsToBounds = true
        characterImageView.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            characterNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            characterNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            characterNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            characterImageView.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 16),
            characterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            characterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            characterImageView.heightAnchor.constraint(equalToConstant: 200),
            
            characterStatusLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 16),
            characterStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            characterStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            characterSpeciesLabel.topAnchor.constraint(equalTo: characterStatusLabel.bottomAnchor, constant: 16),
            characterSpeciesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            characterSpeciesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            characterGenderLabel.topAnchor.constraint(equalTo: characterSpeciesLabel.bottomAnchor, constant: 16),
            characterGenderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            characterGenderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        doSomething()
        
    }
    
    
    func doSomething()
    {
        let request = CharacterDetails.FetchCharacter.Request()
        interactor?.fetchCharacterDetails(request: request)
    }
    
    func displayCharacterDetails(viewModel: CharacterDetails.FetchCharacter.ViewModel)
    {
        characterNameLabel.text = viewModel.name
        characterStatusLabel.text = "Status: \(viewModel.status)"
        characterSpeciesLabel.text = "Species: \(viewModel.species)"
        characterGenderLabel.text = "Gender: \(viewModel.gender)"
        
        if let url = URL(string: viewModel.imageUrl) {
            URLSession.shared.dataTask(with: url) { data, _ , error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.characterImageView.image = image
                    }
                }
            }.resume()
        }
    }
}

//
//  CharacterListViewController.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol CharacterListDisplayLogic: class
{
    func displayCharacter(viewModel: CharacterList.FetchCharacter.ViewModel)
}

class CharacterListViewController: UIViewController, CharacterListDisplayLogic
{
    var interactor: CharacterListBusinessLogic?
    var router: (NSObjectProtocol & CharacterListRoutingLogic & CharacterListDataPassing)?
    
    private let tableView = UITableView()
    private var characters: [CharacterList.CharacterDisplay] = []
    private var isLoading = false
    
    //MARK: - Setup TableView
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        view.addSubview(tableView)
    }
    
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
        let interactor = CharacterListInteractor()
        let presenter = CharacterListPresenter()
        let router = CharacterListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTableView()
        doSomething()
        self.title = "Rick and Morty"
    }
    
    func doSomething()
    {
        let request = CharacterList.FetchCharacter.Request()
        interactor?.doCharacters(request: request)
        
    }
    
    func displayCharacter(viewModel: CharacterList.FetchCharacter.ViewModel)
    {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.characters.append(contentsOf: viewModel.displayCharacter)
            self.tableView.reloadData()
            
            isLoading = false
        }
        
    }
    
    private func loadNextPage() {
        guard !isLoading else { return }
        guard let nextPage = router?.dataStore?.nextPageUrl else { return }
        
        isLoading = true
        let request = CharacterList.FetchCharacter.Request(urlString: nextPage)
        interactor?.doCharacters(request: request)
    }
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.configure(with: characters[indexPath.row])
        return cell
    }
    
    
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row) \(characters[indexPath.row].name)")
        router?.dataStore?.selectedCharacter = characters[indexPath.row]
        print(characters[indexPath.row])
        router?.routeToCharacterDetails()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight - 100 {
            loadNextPage()
        }
    }
}

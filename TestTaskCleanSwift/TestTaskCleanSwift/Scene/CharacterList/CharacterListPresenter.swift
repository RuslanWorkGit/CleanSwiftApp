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
  func presentSomething(response: CharacterList.Something.Response)
}

class CharacterListPresenter: CharacterListPresentationLogic
{
  weak var viewController: CharacterListDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: CharacterList.Something.Response)
  {
    let viewModel = CharacterList.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}

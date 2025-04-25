//
//  CharacterDetailsPresenter.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol CharacterDetailsPresentationLogic
{
  func presentSomething(response: CharacterDetails.Something.Response)
}

class CharacterDetailsPresenter: CharacterDetailsPresentationLogic
{
  weak var viewController: CharacterDetailsDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: CharacterDetails.Something.Response)
  {
    let viewModel = CharacterDetails.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}

//
//  CharacterDetailsInteractor.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CharacterDetailsBusinessLogic
{
  func doSomething(request: CharacterDetails.Something.Request)
}

protocol CharacterDetailsDataStore
{
  //var name: String { get set }
}

class CharacterDetailsInteractor: CharacterDetailsBusinessLogic, CharacterDetailsDataStore
{
  var presenter: CharacterDetailsPresentationLogic?
  var worker: CharacterDetailsWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: CharacterDetails.Something.Request)
  {
    worker = CharacterDetailsWorker()
    worker?.doSomeWork()
    
    let response = CharacterDetails.Something.Response()
    presenter?.presentSomething(response: response)
  }
}

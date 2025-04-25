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
  func doSomething(request: CharacterList.Something.Request)
}

protocol CharacterListDataStore
{
  //var name: String { get set }
}

class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore
{
  var presenter: CharacterListPresentationLogic?
  var worker: CharacterListWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: CharacterList.Something.Request)
  {
    worker = CharacterListWorker()
    worker?.doSomeWork()
    
    let response = CharacterList.Something.Response()
    presenter?.presentSomething(response: response)
  }
}

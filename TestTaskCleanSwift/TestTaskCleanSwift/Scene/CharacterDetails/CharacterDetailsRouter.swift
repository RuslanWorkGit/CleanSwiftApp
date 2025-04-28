//
//  CharacterDetailsRouter.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 25.04.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol CharacterDetailsRoutingLogic
{
}

protocol CharacterDetailsDataPassing
{
  var dataStore: CharacterDetailsDataStore? { get }
}

class CharacterDetailsRouter: NSObject, CharacterDetailsRoutingLogic, CharacterDetailsDataPassing
{
  weak var viewController: CharacterDetailsViewController?
  var dataStore: CharacterDetailsDataStore?
  
}

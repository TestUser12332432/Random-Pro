//
//  LetterScreenCoordinator.swift
//  Random Pro
//
//  Created by Tatiana Sosina on 16.05.2022.
//  Copyright © 2022 Sosin.bet. All rights reserved.
//

import UIKit

final class LetterScreenCoordinator: Coordinator {
  
  // MARK: - Private property
  
  private let navigationController: UINavigationController
  private var letterScreenModule: LetterScreenModule?
  
  // MARK: - Initialization
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: - Internal property
  
  func start() {
    let letterScreenModule = LetterScreenAssembly().createModule()
    self.letterScreenModule = letterScreenModule
    letterScreenModule.moduleOutput = self
    navigationController.pushViewController(letterScreenModule, animated: true)
  }
}

// MARK: - LetterScreenModuleOutput

extension LetterScreenCoordinator: LetterScreenModuleOutput {
  
}
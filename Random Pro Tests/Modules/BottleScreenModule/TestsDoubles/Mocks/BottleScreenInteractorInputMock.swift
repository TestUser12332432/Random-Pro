//
//  BottleScreenInteractorInputMock.swift
//  Random Pro Tests
//
//  Created by Tatyana Sosina on 09.12.2022.
//  Copyright © 2022 SosinVitalii.com. All rights reserved.
//

import UIKit
@testable import Random_Pro

final class BottleScreenInteractorInputMock: BottleScreenInteractorInput {
  
  // MARK: - Internal properties
  
  weak var output: MainScreenInteractorOutput?
  
  // MARK: - Флаги вызовов функция
  
  var isGeneratesBottleRotationTimeAction: Bool = false
  
  // MARK: - BottleScreenInteractorInput
  
  func generatesBottleRotationTimeAction() {
    isGeneratesBottleRotationTimeAction = true
  }
}

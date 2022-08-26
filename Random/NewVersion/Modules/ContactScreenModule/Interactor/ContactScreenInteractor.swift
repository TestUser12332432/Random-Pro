//
//  ContactScreenInteractor.swift
//  Random Pro
//
//  Created by Tatyana Sosina on 24.08.2022.
//  Copyright © 2022 SosinVitalii.com. All rights reserved.
//

import UIKit

/// События которые отправляем из Interactor в Presenter
protocol ContactScreenInteractorOutput: AnyObject {}

/// События которые отправляем от Presenter ко Interactor
protocol ContactScreenInteractorInput {}

final class ContactScreenInteractor: ContactScreenInteractorInput {
  
  // MARK: - Internal property
  
  weak var output: ContactScreenInteractorOutput?
}
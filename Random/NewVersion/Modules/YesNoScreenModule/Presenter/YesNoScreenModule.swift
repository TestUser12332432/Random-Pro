//
//  YesNoScreenModule.swift
//  Random Pro
//
//  Created by Tatiana Sosina on 12.05.2022.
//  Copyright © 2022 Sosin.bet. All rights reserved.
//

import UIKit

protocol YesNoScreenModuleOutput: AnyObject {
  
  /// Была нажата кнопка (настройки)
  func settingButtonAction()
}

protocol YesNoScreenModuleInput: AnyObject {
  
  /// События которые отправляем из `текущего модуля` в  `другой модуль`
  var moduleOutput: YesNoScreenModuleOutput? { get set }
}

typealias YesNoScreenModule = UIViewController & YesNoScreenModuleInput

final class YesNoScreenViewController: YesNoScreenModule {
  
  // MARK: - Internal property
  
  weak var moduleOutput: YesNoScreenModuleOutput?
  
  // MARK: - Private property
  
  private let moduleView: YesNoScreenViewProtocol
  private let interactor: YesNoScreenInteractorInput
  private let factory: YesNoScreenFactoryInput
  
  // MARK: - Initialization
  
  /// - Parameters:
  ///   - interactor: интерактор
  ///   - moduleView: вью
  ///   - factory: фабрика
  init(moduleView: YesNoScreenViewProtocol,
       interactor: YesNoScreenInteractorInput,
       factory: YesNoScreenFactoryInput) {
    self.moduleView = moduleView
    self.interactor = interactor
    self.factory = factory
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Initernal func
  
  override func loadView() {
    super.loadView()
    view = moduleView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    interactor.getContent()
    setupNavBar()
  }
  
  // MARK: - Private func
  
  private func setupNavBar() {
    let appearance = Appearance()
    
    navigationController?.navigationBar.prefersLargeTitles = false
    title = appearance.title
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: appearance.settingsButtonIcon,
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(settingButtonAction))
  }
  
  @objc private func settingButtonAction() {
    moduleOutput?.settingButtonAction()
  }
}

// MARK: - YesNoScreenViewOutput

extension YesNoScreenViewController: YesNoScreenViewOutput {
  func generateButtonAction() {
    interactor.generateContent()
  }
}

// MARK: - YesNoScreenInteractorOutput

extension YesNoScreenViewController: YesNoScreenInteractorOutput {
  func didRecive(result: String?) {
    moduleView.set(result: result)
  }
  
  func didRecive(listResult: [String]) {
    factory.reverse(listResult: listResult)
  }
}

// MARK: - YesNoScreenFactoryOutput

extension YesNoScreenViewController: YesNoScreenFactoryOutput {
  func didReverse(listResult: [String]) {
    moduleView.set(listResult: listResult)
  }
}

// MARK: - Private Appearance

private extension YesNoScreenViewController {
  struct Appearance {
    let title = NSLocalizedString("Да или Нет", comment: "")
    let settingsButtonIcon = UIImage(systemName: "gear")
  }
}
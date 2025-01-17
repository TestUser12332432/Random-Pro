//
//  YesNoScreenView.swift
//  Random Pro
//
//  Created by Tatyana Sosina on 12.05.2022.
//  Copyright © 2022 SosinVitalii.com. All rights reserved.
//

import UIKit
import RandomUIKit

protocol YesNoScreenViewOutput: AnyObject {
  
  /// Пользователь нажал на кнопку
  func generateButtonAction()
}

protocol YesNoScreenViewInput {
  
  /// Устанавливаем данные в result
  ///  - Parameter result: результат генерации
  func set(result: String?)
  
  /// Устанавливает список результатов
  ///  - Parameter listResult: массив результатов
  func set(listResult: [String])
}

typealias YesNoScreenViewProtocol = UIView & YesNoScreenViewInput

final class YesNoScreenView: YesNoScreenViewProtocol {
  
  // MARK: - Internal property
  
  weak var output: YesNoScreenViewOutput?
  
  // MARK: - Private property
  
  private let resultLabel = UILabel()
  private let scrollResult = ScrollLabelGradientView()
  private let generateButton = ButtonView()
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super .init(frame: frame)
    
    setupDefaultSettings()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Internal func
  
  func set(result: String?) {
    resultLabel.text = result
    resultLabel.zoomIn(duration: Appearance().resultDuration,
                       transformScale: CGAffineTransform(scaleX: .zero, y: .zero))
  }
  
  func set(listResult: [String]) {
    scrollResult.listLabels = listResult
  }
}

// MARK: - Private

private extension YesNoScreenView {
  func setupDefaultSettings() {
    backgroundColor = RandomColor.primaryWhite
    
    resultLabel.font = RandomFont.primaryBold70
    resultLabel.textColor = RandomColor.primaryGray
    resultLabel.textAlignment = .center
    
    generateButton.setTitle(Appearance().buttonTitle, for: .normal)
    generateButton.addTarget(self, action: #selector(generateButtonAction), for: .touchUpInside)
  }
  
  func setupConstraints() {
    let appearance = Appearance()
    
    [resultLabel, scrollResult, generateButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      resultLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      resultLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      generateButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: appearance.defaultInset),
      generateButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                               constant: -appearance.defaultInset),
      generateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                             constant: -appearance.defaultInset),
      
      scrollResult.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollResult.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollResult.bottomAnchor.constraint(equalTo: generateButton.topAnchor,
                                           constant: -appearance.minInset)
    ])
  }
  
  @objc
  func generateButtonAction() {
    output?.generateButtonAction()
  }
}

// MARK: - Appearance

private extension YesNoScreenView {
  struct Appearance {
    let buttonTitle = NSLocalizedString("Да или Нет", comment: "")
    
    let defaultInset: CGFloat = 16
    let maxInset: CGFloat = 24
    let minInset: CGFloat = 8
    let resultDuration: CGFloat = 0.2
  }
}

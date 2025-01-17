//
//  MainSettingsScreenType.swift
//  Random Pro
//
//  Created by Vitalii Sosin on 16.09.2022.
//  Copyright © 2022 SosinVitalii.com. All rights reserved.
//

import Foundation

// MARK: - MainSettingsScreenType

/// Моделька для таблички
enum MainSettingsScreenType {
  
  /// Секция `Заголовок и переключатель`
  /// - Parameters:
  ///  - title: Заголовок
  ///  - isEnabled: Переключатель
  case titleAndSwitcher(title: String, isEnabled: Bool)
  
  /// Секция `Заголовок и иконка сбоку`
  /// - Parameters:
  ///  - title: Заголовок
  ///  - asideImage: Иконка сбоку
  ///  - type: Тип секции
  case titleAndImage(title: String, asideImage: Data?, type: SectionType)
  
  /// Секция отступа
  case insets(Double)
  
  /// Разделитель
  case divider
  
  /// Тип выбранной секции
  enum SectionType {
    
    /// Раздел настройки главных секций
    case customMainSections
  }
}

//
//  SettingsScreenView.swift
//  Random Pro
//
//  Created by Vitalii Sosin on 23.05.2022.
//

import UIKit
import RandomUIKit

/// События которые отправляем из View в Presenter
protocol SettingsScreenViewOutput: AnyObject {
  
  /// Событие, без повторений
  /// - Parameter isOn: Без повторений `true` или `false`
  func withoutRepetitionAction(isOn: Bool)
  
  /// Событие, кнопка `Очистить` была нажата
  func cleanButtonAction()
  
  /// Событие, кнопка `Список чисел` была нажата
  func listOfObjectsAction()
}

/// События которые отправляем от Presenter ко View
protocol SettingsScreenViewInput: AnyObject {
  
  /// Обновить контент
  ///  - Parameter models: Массив моделек
  func updateContentWith(models: [Any])
}

/// Псевдоним протокола UIView & SettingsScreenViewInput
typealias SettingsScreenViewProtocol = UIView & SettingsScreenViewInput

/// View для экрана
final class SettingsScreenView: SettingsScreenViewProtocol {
  
  // MARK: - Public properties
  
  // MARK: - Internal properties
  
  weak var output: SettingsScreenViewOutput?
  
  // MARK: - Private properties
  
  private let tableView = UITableView()
  private var models: [Any] = []
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureLayout()
    applyDefaultBehavior()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Public func
  
  // MARK: - Internal func
  
  func updateContentWith(models: [Any]) {
    self.models = models
    tableView.reloadData()
  }
  
  // MARK: - Private func
  
  private func configureLayout() {
    let appearance = Appearance()
    [tableView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: appearance.inset.left),
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -appearance.inset.right),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  private func applyDefaultBehavior() {
    backgroundColor = RandomColor.primaryWhite
    tableView.backgroundColor = RandomColor.primaryWhite
    
    // Сами self(SettingsScreenView) получает события от tableView
    tableView.delegate = self
    
    // Сами self(SettingsScreenView) устанавливаем данные для отображения в tableView
    tableView.dataSource = self
    
    // Зарегистрировали ячейку в табличке
    tableView.register(LabelAndSwitchCell.self,
                       forCellReuseIdentifier: LabelAndSwitchCell.reuseIdentifier)
    tableView.register(DoubleTitleCell.self,
                       forCellReuseIdentifier: DoubleTitleCell.reuseIdentifier)
    tableView.register(LabelAndImageCell.self,
                       forCellReuseIdentifier: LabelAndImageCell.reuseIdentifier)
    tableView.register(SmallButtonCell.self,
                       forCellReuseIdentifier: SmallButtonCell.reuseIdentifier)
    tableView.register(CustomPaddingCell.self,
                       forCellReuseIdentifier: CustomPaddingCell.reuseIdentifier)
    
    tableView.tableFooterView = UIView()
    tableView.tableHeaderView = UIView()
    tableView.contentInset.top = Appearance().inset.top
  }
}

// MARK: - UITableViewDelegate

extension SettingsScreenView: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard models[indexPath.row] is ListOfObjectsSettingsModel else {
      return
    }
    output?.listOfObjectsAction()
  }
}

// MARK: - UITableViewDataSource

extension SettingsScreenView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.row]
    
    if let model = model as? WithoutRepetitionSettingsModel {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: LabelAndSwitchCell.reuseIdentifier
      ) as! LabelAndSwitchCell
      
      cell.configureCellWith(titleText: model.title,
                             isResultSwitch: model.isEnabled)
      cell.switchAction = { [weak self] isOn in
        self?.output?.withoutRepetitionAction(isOn: isOn)
      }
      cell.layer.cornerRadius = Appearance().cornerRadius
      cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      return cell
    }
    
    if let model = model as? CountGeneratedSettingsModel {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: DoubleTitleCell.reuseIdentifier
      ) as! DoubleTitleCell
      
      cell.configureCellWith(primaryText: model.title,
                             secondaryText: model.countGeneratedText)
      return cell
    }
    
    if let model = model as? LastObjectSettingsModel {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: DoubleTitleCell.reuseIdentifier
      ) as! DoubleTitleCell
      
      cell.configureCellWith(primaryText: model.title,
                             secondaryText: model.lastObjectText)
      return cell
    }
    
    if let model = model as? ListOfObjectsSettingsModel {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: LabelAndImageCell.reuseIdentifier
      ) as! LabelAndImageCell
      
      cell.configureCellWith(titleText: model.title,
                             imageAside: model.asideImage)
      return cell
    }
    
    if let model = model as? CleanButtonSettingsModel {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: SmallButtonCell.reuseIdentifier
      ) as! SmallButtonCell
      
      cell.action = { [weak self] in
        self?.output?.cleanButtonAction()
      }
      cell.configureCellWith(titleButton: model.title)
      cell.isHiddenSeparator = true
      cell.layer.cornerRadius = Appearance().cornerRadius
      cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
      return cell
    }
    return UITableViewCell()
  }
}

// MARK: - Appearance

private extension SettingsScreenView {
  struct Appearance {
    let inset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    let cornerRadius: CGFloat = 8
  }
}
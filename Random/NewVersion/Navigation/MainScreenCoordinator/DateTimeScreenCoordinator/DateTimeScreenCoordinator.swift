//
//  DateTimeScreenCoordinator.swift
//  Random Pro
//
//  Created by Tatiana Sosina on 13.05.2022.
//  Copyright © 2022 Sosin.bet. All rights reserved.
//

import UIKit

typealias DateTimeScreenCoordinatorProtocol = Coordinator<Void, String>

final class DateTimeScreenCoordinator: DateTimeScreenCoordinatorProtocol {
    
    // MARK: - Private property
    
    private let navigationController: UINavigationController
    private var dateTimeScreenModule: DateTimeModule?
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal func
    
    override func start(parameter: Void) {
        let dateTimeScreenModule = DateTimeAssembly().createModule()
        self.dateTimeScreenModule = dateTimeScreenModule
        dateTimeScreenModule.moduleOutput = self
        navigationController.pushViewController(dateTimeScreenModule, animated: true)
    }
}

// MARK: - DateTimeModuleOutput

extension DateTimeScreenCoordinator: DateTimeModuleOutput {
    func settingButtonAction() {
    }
}

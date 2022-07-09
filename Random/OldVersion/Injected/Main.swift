//
//  Main.swift
//  Random
//
//  Created by Vitalii Sosin on 07.02.2021.
//  Copyright © 2021 SosinVitalii.com. All rights reserved.
//

import UIKit

extension AppState.AppData {
    struct Main: Equatable {
        var storeCellMenu = AppActions.MainActions.MenuName.allCases.compactMap {
            $0.rawValue
        }
        
        var storeCellMenuHidden: [String] = []
        
        var presenSettingsView = false
    }
}

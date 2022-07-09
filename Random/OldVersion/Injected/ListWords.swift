//
//  ListWords.swift
//  Random
//
//  Created by Vitalii Sosin on 07.02.2021.
//  Copyright © 2021 SosinVitalii.com. All rights reserved.
//

import Foundation

extension AppState.AppData {
    struct ListWords: Equatable {
        var listResult: [String] = []
        var listTemp: [String] = []
        var listData: [String] = []
        var result: String = "?"
        var showSettings = false
        var noRepetitions = true
    }
}

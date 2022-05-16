//
//  AppEnvironment.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 16/5/22.
//

import Foundation

class AppEnvironment: ObservableObject {

    @Published private var localizationManagerWillChange: Void = ()

    let localizationManager: LocalizationManager = .init()

    init() {
        localizationManager.objectWillChange.assign(to: &$localizationManagerWillChange)
    }
}

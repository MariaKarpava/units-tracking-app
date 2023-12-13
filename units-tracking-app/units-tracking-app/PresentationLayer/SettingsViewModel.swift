//
//  SettingsViewModel.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 02/12/2023.
//

import Foundation
import SwiftUI


extension Notification.Name {
    static let dailyLimitHasChanged = Notification.Name("dailyLimitHasChanged")
    static let weeklyLimitHasChanged = Notification.Name("weeklyLimitHasChanged")
}


class SettingsViewModel: ObservableObject {
    private let drinksService: DrinksService
    private let goalsService: GoalsService
    @Published var viewState: ViewState

    init(drinksService: DrinksService, goalsService: GoalsService) {
        self.drinksService = drinksService
        self.goalsService = goalsService
        self.viewState = ViewState()
        self.updateViewState()
    }
    
    
    struct ViewState: Equatable {
        var dailyLimit: Double = 1.0
        var weeklyLimit: Double = 2.0
    }
    
    private func updateViewState() {
        viewState.dailyLimit = goalsService.unitsPerDay
        viewState.weeklyLimit = goalsService.unitsPer7Days
    }
    
    func decrementDailyLimitTapped() {
        viewState.dailyLimit -= 1.0
    }
    
    func incrementDailyLimitTapped() {
        viewState.dailyLimit += 1.0
    }
}



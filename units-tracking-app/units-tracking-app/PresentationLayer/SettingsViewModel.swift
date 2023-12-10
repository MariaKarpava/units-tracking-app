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
        
        NotificationCenter.default.addObserver(
            forName: .dailyLimitHasChanged,
            object: goalsService,
            queue: .main
        ) { [weak self] notification in
            guard let strongSelf = self else { return }
            strongSelf.updateViewState()
        }
        
        NotificationCenter.default.addObserver(
            forName: .weeklyLimitHasChanged,
            object: goalsService,
            queue: .main
        ) { [weak self] notification in
            guard let strongSelf = self else { return }
            strongSelf.updateViewState()
        }
    }
    
    
    struct ViewState: Equatable {
        var dailyLimit: Double = 1.0
        var weeklyLimit: Double = 2.0
    }
    
    private func updateViewState() {
        viewState.dailyLimit = goalsService.unitsPerDay
        viewState.weeklyLimit = goalsService.unitsPer7Days
    }
}



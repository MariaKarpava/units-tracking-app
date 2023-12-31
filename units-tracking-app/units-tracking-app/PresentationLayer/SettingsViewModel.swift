//
//  SettingsViewModel.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 02/12/2023.
//

import Foundation
import SwiftUI


class SettingsViewModel: ObservableObject {
    private let goalsService: GoalsService
    @Published var viewState: ViewState

    init(goalsService: GoalsService) {
        self.goalsService = goalsService
        self.viewState = ViewState()
        self.updateViewState()
    }
    
    struct ViewState: Equatable {
        var dailyLimit: Double = 1.0
        var weeklyLimit: Double = 2.0
    }
    
    func updateViewState() {
        viewState.dailyLimit = goalsService.unitsPerDay
        viewState.weeklyLimit = goalsService.unitsPer7Days
    }

}



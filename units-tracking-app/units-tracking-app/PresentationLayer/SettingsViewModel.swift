//
//  SettingsViewModel.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 02/12/2023.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    private let drinksService: DrinksService
    private let goalsService: GoalsService
    
    init(drinksService: DrinksService, goalsService: GoalsService) {
        self.drinksService = drinksService
        self.goalsService = goalsService
    }
    
    func getDailyLimit() -> Double {
        goalsService.unitsPerDay
    }
    
    func getWeeklyLimit() -> Double {
        goalsService.unitsPer7Days
    }
}



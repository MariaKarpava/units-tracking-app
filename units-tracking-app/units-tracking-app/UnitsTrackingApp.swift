//
//  units_tracking_appApp.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

@main
struct UnitsTrackingApp: App {
    var goalsService: GoalsService
    var drinkService: DrinksService
    
    init() {
        let goalsService = GoalsService()
        self.drinkService = DrinksService(goalsService: goalsService)
        self.goalsService = goalsService
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(
                homeViewModel: HomeViewModel(drinksService: drinkService, goalsService: goalsService),
                historyViewModel: HistoryViewModel(drinksService: drinkService), 
                settingsViewModel: SettingsViewModel(goalsService: goalsService),
                limitViewModel: LimitViewModel(goalsService: goalsService),
                drinksService: drinkService,
                goalsService: goalsService)
        }
    }
}






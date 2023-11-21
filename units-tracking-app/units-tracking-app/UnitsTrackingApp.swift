//
//  units_tracking_appApp.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

@main
struct UnitsTrackingApp: App {
    @StateObject var goalsService = GoalsService()
    var drinkService = DrinksService()
    

    var body: some Scene {
        WindowGroup {
            RootView(homeViewModel: HomeViewModel(drinksService: drinkService, goalsService: goalsService), historyViewModel: HistoryViewModel(drinksService: drinkService), drinksService: drinkService, goalsService: goalsService)
        }
    }
}






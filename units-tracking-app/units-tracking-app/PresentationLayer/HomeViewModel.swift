//
//  HomeView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 06/09/2023.
//

import Foundation
import SwiftUI


class HomeViewModel: ObservableObject {
    private let drinksService: DrinksService
    private let goalsService: GoalsService
    
    init(drinksService: DrinksService, goalsService: GoalsService) {
        self.drinksService = drinksService
        self.goalsService = goalsService
    }
    
    var colorForUnits: Color {
        if drinksService.unitsRemainingForToday >= goalsService.getUnitsPerDay {
            return Color("MainTextColor")
        } else {
            return Color("CustomOrange")
        }
    }
    
    var getUnitsRemainingForToday: Double {
        drinksService.unitsRemainingForToday
    }
}

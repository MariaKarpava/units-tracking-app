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
        enum DrinkState {
            case normal
            case closeToZero
            case remainingIsZero
        }
        
        let unitsRemainingForToday = drinksService.unitsRemainingForToday
        var currentDrinkState: DrinkState
        
        if unitsRemainingForToday > 3.0 {
            currentDrinkState = .normal
        } else if unitsRemainingForToday >= 1.0 {
            currentDrinkState = .closeToZero
        } else {
            currentDrinkState = .remainingIsZero
        }
            
        
        switch currentDrinkState {
        case .normal:
            return Color("MainTextColor")
        case .closeToZero:
            return Color("CustomOrange")
        case .remainingIsZero:
            return Color.red
        }
    }
    
    
    var getUnitsRemainingForToday: Double {
        print("HVM: drinksService.unitsRemainingForToday: \(drinksService.unitsRemainingForToday)")
        return drinksService.unitsRemainingForToday
    }
    
    func getInfoText() -> String {
        print(drinksService.infoText)
        return drinksService.infoText
    }
}

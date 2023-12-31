//
//  HomeView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 06/09/2023.
//

import Foundation
import SwiftUI


extension Notification.Name {
    static let drinksHasChanged = Notification.Name("drinksHasChanged")
}


class HomeViewModel: ObservableObject {
    private let drinksService: DrinksService
    private let goalsService: GoalsService
    @Published var viewState: ViewState
    
    enum DrinkState {
        case normal
        case closeToZero
        case remainingIsZero
    }
    
    
    struct ViewState: Equatable {
        enum RemainingUnitsIndication: Equatable {
            case warning
            case exactNumber(units: Double, color: Color)
        }
        var text: String = ""
        var remainingUnitsIndication: RemainingUnitsIndication = .exactNumber(units: -1, color: .blue)
    }
    
    
    init(drinksService: DrinksService, goalsService: GoalsService) {
        self.drinksService = drinksService
        self.goalsService = goalsService
        self.viewState = ViewState()
        
        self.updateViewState()
 
        NotificationCenter.default.addObserver(
            forName: .drinksHasChanged,
            object: drinksService,
            queue: .main
        ) { [weak self] notification in
            // Handle the notification here
            guard let strongSelf = self else { return }
            strongSelf.updateViewState()
        }
        
        NotificationCenter.default.addObserver(
            forName: GoalsService.NotificationName.dailyLimitHasChanged,
            object: goalsService,
            queue: .main
        ) { [weak self] notification in
            // Handle the notification here
            guard let strongSelf = self else { return }
            strongSelf.updateViewState()
            print("Home: view state updated: .dailyLimitHasChanged")
        }
        
        NotificationCenter.default.addObserver(
            forName: GoalsService.NotificationName.weeklyLimitHasChanged,
            object: goalsService,
            queue: .main
        ) { [weak self] notification in
            // Handle the notification here
            guard let strongSelf = self else { return }
            strongSelf.updateViewState()
            print("Home: view state updated: .weeklyLimitHasChanged")
        }
    }
    
    func updateViewState() {
        let drinkState = calculateCurrentDrinkState()
        if drinkState == .normal || drinkState == .closeToZero {
            viewState.text = "units remaining \n for today."
            viewState.remainingUnitsIndication = .exactNumber(units: drinksService.unitsRemainingForToday(), color: calculateColorForUnits(currentDrinkState: drinkState))
        } else {
            viewState.text = "You have reached your \n drinking limit today."
            viewState.remainingUnitsIndication = .warning
        }
    }
    
    
    
    func calculateColorForUnits(currentDrinkState: DrinkState) -> Color {
        switch currentDrinkState {
        case .normal:
            return .accentColor
        case .closeToZero:
            return .customOrange
        case .remainingIsZero:
            return .red
        }
    }
    
    
    func calculateCurrentDrinkState() -> DrinkState {
        let unitsRemainingForToday = drinksService.unitsRemainingForToday
        
        let unitsAllowedPer7Days = goalsService.unitsPer7Days
        let closeToLimitUnits: Double = unitsAllowedPer7Days * 20 / 100
        
        if unitsRemainingForToday() > closeToLimitUnits {
            return .normal
        } else if unitsRemainingForToday() > 0 {
            return .closeToZero
        } else {
            return .remainingIsZero
        }
    }
    
    
    func whyButtonTapped() {
        print("why button tapped")
    }
}

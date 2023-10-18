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
    
    struct ViewState {
        var colorForUnits: Color = .blue
        var unitsRemainingForToday: Double = -1
    }
    
    
    init(drinksService: DrinksService, goalsService: GoalsService) {
        self.drinksService = drinksService
        self.goalsService = goalsService
        self.viewState = ViewState()
        
        viewState.unitsRemainingForToday = drinksService.unitsRemainingForToday()
        viewState.colorForUnits = calculateColorForUnits()
 
        NotificationCenter.default.addObserver(
            forName: .drinksHasChanged,
            
            object: drinksService,
            queue: .main
            // Handle the notification here
            print("Received a notification! \(Date())")
        }
    }
    
    
    func calculateColorForUnits() -> Color {
        enum DrinkState {
            case normal
            case closeToZero
            case remainingIsZero
        }
        
        let unitsRemainingForToday = drinksService.unitsRemainingForToday
        var currentDrinkState: DrinkState
        
        if unitsRemainingForToday() > 3.0 {
            currentDrinkState = .normal
        } else if unitsRemainingForToday() > 0 {
            currentDrinkState = .closeToZero
        } else {
            currentDrinkState = .remainingIsZero
        }
            
        switch currentDrinkState {
        case .normal:
            return .mainText
        case .closeToZero:
            return .customOrange
        case .remainingIsZero:
            return .red
        }
    }
    
    func whyButtonTapped() {
        print("why button tapped")
    }
}

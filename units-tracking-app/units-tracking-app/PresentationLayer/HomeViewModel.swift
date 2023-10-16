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
    
    init(drinksService: DrinksService, goalsService: GoalsService) {
        self.drinksService = drinksService
        self.goalsService = goalsService
        unitsRemainingForToday = drinksService.unitsRemainingForToday()
        colorForUnits = calculateColorForUnits()
        
        NotificationCenter.default.addObserver(
            forName: .drinksHasChanged,
            object: drinksService,
            queue: .main
        ) { notification in
            // Handle the notification here
            print("Received a notification! \(Date())")
            
            self.unitsRemainingForToday = self.drinksService.unitsRemainingForToday()
            self.colorForUnits = self.calculateColorForUnits()
        }
    }
    

    
    @Published var colorForUnits: Color = .blue
    func calculateColorForUnits() -> Color {
        print("---")
        print("---")
        print("calculateColorForUnits()")
        print("---")
        print("---")
        
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
    
    @Published var unitsRemainingForToday: Double
    
    func whyButtonTapped() {
        print("why button tapped")
    }
}

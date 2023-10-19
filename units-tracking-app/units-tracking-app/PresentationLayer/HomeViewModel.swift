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
    
    
    struct ViewState {
        enum RemainingUnitsIndication {
            case warning
            case exactNumber
        }
        
        var colorForUnits: Color = .blue
        var unitsRemainingForToday: Double = -1
        var text: String = ""
        
        var remainingUnitsIndication: RemainingUnitsIndication = .exactNumber
    }
    
    
    init(drinksService: DrinksService, goalsService: GoalsService) {
        self.drinksService = drinksService
        self.goalsService = goalsService
        self.viewState = ViewState()
        
        viewState.unitsRemainingForToday = drinksService.unitsRemainingForToday()
        let drinkState = calculateCurrentDrinkState()
        viewState.colorForUnits = calculateColorForUnits(currentDrinkState: drinkState)
        viewState.text = "Units remaining \n for today"
        viewState.remainingUnitsIndication = .exactNumber
 
        NotificationCenter.default.addObserver(
            forName: .drinksHasChanged,
            
            object: drinksService,
            queue: .main
        ) { [weak self] notification in
            // Handle the notification here
            guard let strongSelf = self else { return }
//            print("Received a notification! \(Date())")
            strongSelf.viewState.unitsRemainingForToday = strongSelf.drinksService.unitsRemainingForToday()
            
            let drinkState = strongSelf.calculateCurrentDrinkState()
            strongSelf.viewState.colorForUnits = strongSelf.calculateColorForUnits(currentDrinkState: drinkState)
            if drinkState == .normal || drinkState == .closeToZero {
                strongSelf.viewState.text = "units remaining \n for today."
                strongSelf.viewState.remainingUnitsIndication = .exactNumber
            } else {
                strongSelf.viewState.text = "You have reached your \n drinking limit today."
                strongSelf.viewState.remainingUnitsIndication = .warning            }
        }
    }
    
    
    
    
    
    func calculateColorForUnits(currentDrinkState: DrinkState) -> Color {
        switch currentDrinkState {
        case .normal:
            return .mainText
        case .closeToZero:
            return .customOrange
        case .remainingIsZero:
            return .red
        }
    }
    
    
    func calculateCurrentDrinkState() -> DrinkState {
        let unitsRemainingForToday = drinksService.unitsRemainingForToday
        
        if unitsRemainingForToday() > 3.0 {
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

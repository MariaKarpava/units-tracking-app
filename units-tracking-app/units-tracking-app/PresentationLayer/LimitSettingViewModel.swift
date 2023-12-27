//
//  LimitViewModel.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 17/12/2023.
//

import Foundation
import SwiftUI


class LimitSettingViewModel: ObservableObject {
    private let goalsService: GoalsService
    @Published var viewState: ViewState
    private var limitType: LimitType

    
    enum LimitType {
        case daily
        case weekly
    }

    init(goalsService: GoalsService, limitType: LimitType) {
        self.goalsService = goalsService
        self.viewState = ViewState()
        self.limitType = limitType
        self.updateViewState()
        // + TODO:  What's the purpose of these notification center usages? Is it possible to achieve the same without broadcasting?
    }
    
    struct ViewState: Equatable {
        var units: Double = 1.0
        var oldUnits: Double = 1.0
        var decrementButtonIsNotActive: Bool = false
        var saveButtonIsNotActive: Bool = true
        var title: String = "Daily Limit"
        var buttonColor: Color = .accentColor
        
        // + TODO: Save button should not always be enabled. It's enabled only when there are unsaved changes.
        // + TODO: Save should be enabled when there are unsaved changes. I.e. 8 -> 9 -> 8 = not enabled.
    }
    
    private func titleForCurrentLimitType() -> String {
        switch limitType {
        case .daily:
            return "Daily Limit"
        case .weekly:
            return "Weekly Limit"
        }
    }
    
    private func checkIfUnitsArePositive() -> Bool {
        return viewState.units > 0
    }
    
    // + TODO: same as with title. Doesn't this name lie about what it's doing?
    // + TODO: NEW: Doesn't this name lie about what it's doing now? :)
    private func buttonColor() -> Color {
        if checkIfUnitsArePositive() {
            viewState.decrementButtonIsNotActive = false
            return .accentColor
        } else {
            viewState.decrementButtonIsNotActive = true
            return .secondaryText
        }
    }
    
    private func updateSaveButtonState(oldUnits: Double) {
        if viewState.units != oldUnits {
            viewState.saveButtonIsNotActive = false
        } else {
            viewState.saveButtonIsNotActive = true
        }
    }
    
    private func updateViewState() {
        if limitType == .daily {
            viewState.units = goalsService.unitsPerDay
            viewState.oldUnits = viewState.units
        } else {
            viewState.units = goalsService.unitsPer7Days
            viewState.oldUnits = viewState.units
        }
        viewState.title = titleForCurrentLimitType()
        viewState.buttonColor = buttonColor()
    }
    
    func decrementUnitsTapped() {
        guard viewState.units > 0 else { return }
        viewState.units -= 1.0
        viewState.buttonColor = buttonColor()
        updateSaveButtonState(oldUnits: viewState.oldUnits)
    }
    
    func incrementUnitsTapped() {
        viewState.units += 1.0
        viewState.buttonColor = buttonColor()
        updateSaveButtonState(oldUnits: viewState.oldUnits)
    }
    
    func saveLimitsTapped() {
        updateGoalsService()
        updateViewState()
        updateSaveButtonState(oldUnits: viewState.oldUnits)
    }
    
    private func updateGoalsService() {
        if limitType == .daily {
            goalsService.changeUnitsPerDay(newValue: viewState.units)
        } else {
            goalsService.changeUnitsPer7Days(newValue: viewState.units)
        }
    }
}

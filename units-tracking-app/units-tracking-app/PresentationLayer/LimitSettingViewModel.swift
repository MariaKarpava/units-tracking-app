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
    }
    
    // TODO: check the info text -- it should be different based on the `limitType`.
    struct ViewState: Equatable {
        var units: Double = 1.0
        var oldUnits: Double = 1.0
        var decrementButtonIsNotActive: Bool = false
        var saveButtonIsNotActive: Bool = true
        var title: String = "Daily Limit"
        var infoText: String = ""
        var buttonColor: Color = .accentColor
    }
    
    private func titleForCurrentLimitType() -> String {
        switch limitType {
        case .daily:
            return "Daily Limit"
        case .weekly:
            return "Weekly Limit"
        }
    }
    
    private func infoTextForCurrentLimitType() -> String {
        switch limitType {
        case .daily:
            return """
            According to the NHS, males should
            not exceed a daily limit of 8 units,
            while for females the value is 6 units. 
            
            Note: there is **no safe** amount of
            alcohol. The more alcohol you
            consume, the higher are the risks.
            """
        case .weekly:
            return """
            According to the NHS, men and women are
            advised not to drink
            more than 14 units a week on a
            regular basis.
            
            Note: there is **no safe** amount of
            alcohol. The more alcohol you
            consume, the higher are the risks.
            """
        }
    }
    
    private func checkIfUnitsArePositive() -> Bool {
        return viewState.units > 0
    }
    
    // + TODO: same as with title. Doesn't this name lie about what it's doing?
    // + TODO: NEW: Doesn't this name lie about what it's doing now? :)
    // TODO: discuss
    private func updateDecrementButton() {
        if checkIfUnitsArePositive() {
            viewState.buttonColor = .accentColor
            viewState.decrementButtonIsNotActive = false
        } else {
            viewState.buttonColor = .secondaryText
            viewState.decrementButtonIsNotActive = true
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
        viewState.infoText = infoTextForCurrentLimitType()
        updateDecrementButton()
    }
    
    func decrementUnitsTapped() {
        guard viewState.units > 0 else { return }
        viewState.units -= 1.0
        updateDecrementButton()
        updateSaveButtonState(oldUnits: viewState.oldUnits)
    }
    
    func incrementUnitsTapped() {
        viewState.units += 1.0
        updateDecrementButton()
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

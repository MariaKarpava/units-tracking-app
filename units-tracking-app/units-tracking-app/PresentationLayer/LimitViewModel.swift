//
//  LimitViewModel.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 17/12/2023.
//

import Foundation


class LimitViewModel: ObservableObject {
    private let goalsService: GoalsService
    @Published var viewState: ViewState
    var limitType: LimitType
    
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
    
    struct ViewState: Equatable {
        var units: Double = 1.0
        var limitType: LimitType = .daily
        var header: String = "Daily Limit"
    }
    
    func updateHeader() -> String {
        limitType == .daily ? "Daily Limit" : "Weekly Limit"
    }
    
    private func updateViewState() {
        if limitType == .daily {
            viewState.units = goalsService.unitsPerDay
        } else {
            viewState.units = goalsService.unitsPer7Days
        }
        viewState.header = updateHeader()
    }
    
    func decrementUnits() {
        guard viewState.units > 0 else { return }
        viewState.units -= 1.0
        updateGoalsService()
    }
    
    func incrementUnits() {
        viewState.units += 1.0
        updateGoalsService()
    }
    
    private func updateGoalsService() {
        if limitType == .daily {
            goalsService.changeUnitsPerDay(newValue: viewState.units)
        } else {
            goalsService.changeUnitsPer7Days(newValue: viewState.units)
        }
    }
}

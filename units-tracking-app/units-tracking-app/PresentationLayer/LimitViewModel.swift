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
        var dailyLimit: Double = 1.0
        var weeklyLimit: Double = 2.0
        var limitType: LimitType = .daily
        var header: String = "Daily Limit"
    }
    
    private func updateViewState() {
        viewState.dailyLimit = goalsService.unitsPerDay
        viewState.weeklyLimit = goalsService.unitsPer7Days
    }
    
    func decrementDailyLimitTapped() {
        guard viewState.dailyLimit > 0 else { return }
        viewState.dailyLimit -= 1.0
        updateGoalsService()
    }
    
    func incrementDailyLimitTapped() {
        viewState.dailyLimit += 1.0
        updateGoalsService()
    }
    func decrementWeeklyLimitTapped() {
        guard viewState.weeklyLimit > 0 else { return }
        viewState.weeklyLimit -= 1.0
        updateGoalsService()
    }
    
    func incrementWeeklyLimitTapped() {
        viewState.weeklyLimit += 1.0
        updateGoalsService()
    }
    
    private func updateGoalsService() {
        goalsService.changeUnitsPerDay(newValue: viewState.dailyLimit)
        goalsService.changeUnitsPer7Days(newValue: viewState.weeklyLimit)
    }
}

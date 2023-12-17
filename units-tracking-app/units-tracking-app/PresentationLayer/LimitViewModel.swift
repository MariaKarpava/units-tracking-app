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

    init(goalsService: GoalsService) {
        self.goalsService = goalsService
        self.viewState = ViewState()
        self.updateViewState()
    }
    
    struct ViewState: Equatable {
        var dailyLimit: Double = 1.0
        var weeklyLimit: Double = 2.0
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
        guard viewState.dailyLimit < 100 else { return }
        viewState.dailyLimit += 1.0
        updateGoalsService()
    }
    func decrementWeeklyLimitTapped() {
        guard viewState.weeklyLimit > 0 else { return }
        viewState.weeklyLimit -= 1.0
        updateGoalsService()
    }
    
    func incrementWeeklyLimitTapped() {
        guard viewState.weeklyLimit < 100 else { return }
        viewState.weeklyLimit += 1.0
        updateGoalsService()
    }
    
    private func updateGoalsService() {
        goalsService.changeUnitsPerDay(newValue: viewState.dailyLimit)
        goalsService.changeUnitsPer7Days(newValue: viewState.weeklyLimit)
        
        print("goalsService.unitsPerDay \(goalsService.unitsPerDay)")
        print("goalsService.changeUnitsPer7Days \(goalsService.unitsPer7Days)")
    }
}
//
//  LimitViewModel.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 17/12/2023.
//

import Foundation
import SwiftUI


extension Notification.Name {
    static let dailyLimitHasChanged = Notification.Name("dailyLimitHasChanged")
    static let weeklyLimitHasChanged = Notification.Name("weeklyLimitHasChanged")
}


class LimitSettingViewModel: ObservableObject {
    private let goalsService: GoalsService
    @Published var viewState: ViewState
    private var limitType: LimitType // + TODO: encapsulation: how is supposed to be using it from the outside?
    
    enum LimitType {
        case daily
        case weekly
    }

    init(goalsService: GoalsService, limitType: LimitType) {
        self.goalsService = goalsService
        self.viewState = ViewState()
        self.limitType = limitType
        self.updateViewState()
        
        NotificationCenter.default.addObserver(
            forName: .dailyLimitHasChanged,
            object: self,
            queue: .main
        ) { [ weak self ] notification in
            // Handle the notification here
            guard let strongSelf = self else { return }
            strongSelf.updateViewState()
            print("Received a notification in LimitSettingViewModel! DailyLimitHasChanged!")
        }
        
        NotificationCenter.default.addObserver(
            forName: .weeklyLimitHasChanged,
            object: self,
            queue: .main
        ) { [ weak self ] notification in
            // Handle the notification here
            guard let strongSelf = self else { return }
            strongSelf.updateViewState()
            print("Received a notification in LimitSettingViewModel! WeeklyLimitHasChanged!")
        }
    }
    
    struct ViewState: Equatable {
        var units: Double = 1.0
        var areUnitsPositive: Bool = true
        var limitType: LimitType = .daily
        var title: String = "Daily Limit"
        var buttonColor: Color = .mainText
    }
    
    // + TODO: misleading name: this is a "pure" function which doesn't have any side effects (which is good), it does not update anything.
    private func titleForCurrentLimitType() -> String {
        switch viewState.limitType {
        case .daily:
            return "Daily Limit"
        case .weekly:
            return "Weekly Limit"
        }
    }
    
    private func checkIfUnitsArePositive() -> Bool {
        return viewState.units > 0
    }
    
    private func updateButtonColor() -> Color {
        if viewState.areUnitsPositive {
            return Color.mainText
        } else {
            return Color.secondaryText
        }
    }
    
    private func updateViewState() {
        if limitType == .daily {
            viewState.units = goalsService.unitsPerDay
        } else {
            viewState.units = goalsService.unitsPer7Days
        }
        viewState.title = titleForCurrentLimitType()
        viewState.buttonColor = updateButtonColor()
    }
    
    func decrementUnitsTapped() {
        guard viewState.units > 0 else { return }
        viewState.units -= 1.0
        viewState.buttonColor = updateButtonColor()
    }
    
    func incrementUnitsTapped() {
        viewState.units += 1.0
    }
    
    func saveLimitsTapped() {
        updateGoalsService()
        updateViewState()
    }
    
    private func updateGoalsService() {
        if limitType == .daily {
            goalsService.changeUnitsPerDay(newValue: viewState.units)
            NotificationCenter.default.post(name: .dailyLimitHasChanged, object: self)
        } else {
            goalsService.changeUnitsPer7Days(newValue: viewState.units)
            NotificationCenter.default.post(name: .weeklyLimitHasChanged, object: self)
        }
    }
}

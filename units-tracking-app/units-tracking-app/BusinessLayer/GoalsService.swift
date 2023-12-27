//
//   GoalsService.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 16/08/2023.
//

import Foundation

// TODO: get rid of magic strings. Add enums `GoalsService.Notification` and `GoalsService.UserDefaultsKey` which would host the constants. Make sure best fitting access modifiers are chosen.


class  GoalsService: ObservableObject {
    /// Returns the number of units per day which is the max value but still within a limit.
    private var unitsPerDay: Double
    
    /// Returns the number of units per 7 days which is the max value but still within a limit.
    private var unitsPer7Days: Double
    
    enum NotificationName {
        static let dailyLimitHasChanged = Notification.Name("dailyLimitHasChanged")
        static let weeklyLimitHasChanged = Notification.Name("weeklyLimitHasChanged")
    }
    
    enum UserDefaultsKey {
        static let dailyLimitHasChanged = "dailyLimitHasChanged"
        static let weeklyLimitHasChanged = "weeklyLimitHasChanged"
    }
    
    init() {
        // Decode the daily limit
        let savedDailyLimit = UserDefaults.standard.double(forKey: UserDefaultsKey.dailyLimitHasChanged)
        unitsPerDay = savedDailyLimit
        
        // Decode the weekly limit
        let savedWeeklyLimit = UserDefaults.standard.double(forKey: UserDefaultsKey.weeklyLimitHasChanged)
        unitsPer7Days = savedWeeklyLimit
    }
    
    func changeUnitsPerDay(newValue: Double) {
        unitsPerDay = newValue
        
        UserDefaults.standard.set(unitsPerDay, forKey: UserDefaultsKey.dailyLimitHasChanged)
        NotificationCenter.default.post(name: NotificationName.dailyLimitHasChanged, object: self)
    }
    
    // TODO: FYI: alternative could be to make the property `private(set) public` -- that way it would have been read-only from outside but read-write from the inside. But current approach is also fine.
    func getUnitsPerDay() -> Double {
        unitsPerDay
    }
    
    func changeUnitsPer7Days(newValue: Double) {
        unitsPer7Days = newValue
        
        UserDefaults.standard.set(unitsPer7Days, forKey: UserDefaultsKey.weeklyLimitHasChanged)
        NotificationCenter.default.post(name: NotificationName.weeklyLimitHasChanged, object: self)
    }
    
    func getUnitsPer7Days() -> Double {
        unitsPer7Days
    }
}

//
//   GoalsService.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 16/08/2023.
//

import Foundation


class GoalsService: ObservableObject {
    /// Returns the number of units per day which is the max value but still within a limit.
    private(set) public var unitsPerDay: Double
    
    /// Returns the number of units per 7 days which is the max value but still within a limit.
    private(set) public var unitsPer7Days: Double
    
    public enum NotificationName {
        static let dailyLimitHasChanged = Notification.Name("dailyLimitHasChanged")
        static let weeklyLimitHasChanged = Notification.Name("weeklyLimitHasChanged")
    }
    
    private enum UserDefaultsKey {
        static let dailyLimitHasChanged = "dailyLimitHasChanged"
        static let weeklyLimitHasChanged = "weeklyLimitHasChanged"
    }
    
    private enum DefaultLimit {
        static let daily = 6.0
        static let weekly = 14.0
    }
    
    init() {
        // Decode the daily limit
        let savedDailyLimit = UserDefaults.standard.double(forKey: UserDefaultsKey.dailyLimitHasChanged)
        if savedDailyLimit == 0 {
            unitsPerDay = DefaultLimit.daily
        } else {
            unitsPerDay = savedDailyLimit
        }
        
        
        // Decode the weekly limit
        let savedWeeklyLimit = UserDefaults.standard.double(forKey: UserDefaultsKey.weeklyLimitHasChanged)
        if savedWeeklyLimit == 0 {
            unitsPer7Days = DefaultLimit.weekly
        } else {
            unitsPer7Days = savedWeeklyLimit
        }
    }
    
    func changeUnitsPerDay(newValue: Double) {
        unitsPerDay = newValue
        
        UserDefaults.standard.set(unitsPerDay, forKey: UserDefaultsKey.dailyLimitHasChanged)
        NotificationCenter.default.post(name: NotificationName.dailyLimitHasChanged, object: self)
    }

    func changeUnitsPer7Days(newValue: Double) {
        unitsPer7Days = newValue
        
        UserDefaults.standard.set(unitsPer7Days, forKey: UserDefaultsKey.weeklyLimitHasChanged)
        NotificationCenter.default.post(name: NotificationName.weeklyLimitHasChanged, object: self)
    }
}

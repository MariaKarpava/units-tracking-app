//
//   GoalsService.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 16/08/2023.
//

import Foundation

// + TODO: get rid of magic strings. Add enums `GoalsService.Notification` and `GoalsService.UserDefaultsKey` which would host the constants. Make sure best fitting access modifiers are chosen.
// TODO: So what about access modifiers?

class  GoalsService: ObservableObject {
    /// Returns the number of units per day which is the max value but still within a limit.
    private(set) public var unitsPerDay: Double
    
    /// Returns the number of units per 7 days which is the max value but still within a limit.
    private(set) public var unitsPer7Days: Double
    
    public enum NotificationName {
        static let dailyLimitHasChanged = Notification.Name("dailyLimitHasChanged")
        static let weeklyLimitHasChanged = Notification.Name("weeklyLimitHasChanged")
    }
    
    // private as: 1.
    private enum UserDefaultsKey {
        static let dailyLimitHasChanged = "dailyLimitHasChanged"
        static let weeklyLimitHasChanged = "weeklyLimitHasChanged"
    }
    
    init() {
        // daily and weekly limits when launching the app
        let launchingDailyLimit = 6.0
        let launchingWeeklyLimit = 14.0
        
        // Decode the daily limit
        let savedDailyLimit = UserDefaults.standard.double(forKey: UserDefaultsKey.dailyLimitHasChanged)
        if savedDailyLimit == 0 {
            unitsPerDay = launchingDailyLimit // TODO: get rid of magic numbers. Also how are the defaults chosen? Does it match NHS recommendation?
        } else {
            unitsPerDay = savedDailyLimit
        }
        
        
        // Decode the weekly limit
        let savedWeeklyLimit = UserDefaults.standard.double(forKey: UserDefaultsKey.weeklyLimitHasChanged)
        if savedWeeklyLimit == 0 {
            unitsPer7Days = launchingWeeklyLimit
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

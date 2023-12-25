//
//   GoalsService.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 16/08/2023.
//

import Foundation


class  GoalsService: ObservableObject {
    // TODO: encapsulation violated. Anyone from outside cabnn change the property,  which makes changeUnitsPerDay(:) not very useful. Make this property read-only. Then get rid of didSet -- we don't need it as we have changeUnitsPerDay(:) already which can host this logic.
    
    // TODO: why usgin inline initialization? We don't need it as the plan is to initialize it form uer defaults instead (already implemented).
    
    /// Returns the number of units per day which is the max value but still within a limit.
    var unitsPerDay: Double = 5.0 {
        didSet {
            UserDefaults.standard.set(unitsPerDay, forKey: "dailyLimitHasChanged")
            print("Daily limit saved and = \(unitsPerDay).")
        }
    }
    /// Returns the number of units per 7 days which is the max value but still within a limit.
    var unitsPer7Days: Double = 14.0 {
        didSet {
            UserDefaults.standard.set(unitsPer7Days, forKey: "weeklyLimitHasChanged")
            print("Weekly limit saved and = \(unitsPer7Days).")
        }
    }
    
    
    init() {
        // Decode the daily limit
        let savedDailyLimit = UserDefaults.standard.double(forKey: "dailyLimitHasChanged")
        unitsPerDay = savedDailyLimit
        
        // Decode the weekly limit
        let savedWeeklyLimit = UserDefaults.standard.double(forKey: "weeklyLimitHasChanged")
        unitsPer7Days = savedWeeklyLimit
    }
    
    func changeUnitsPerDay(newValue: Double) {
        unitsPerDay = newValue
    }
    
    func changeUnitsPer7Days(newValue: Double) {
        unitsPer7Days = newValue
    }
}

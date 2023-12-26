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
    private var unitsPerDay: Double
    
    /// Returns the number of units per 7 days which is the max value but still within a limit.
    private var unitsPer7Days: Double 
    
    
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
        
        UserDefaults.standard.set(unitsPerDay, forKey: "dailyLimitHasChanged")
        NotificationCenter.default.post(name: .dailyLimitHasChanged, object: self)
        print("Daily limit saved and = \(unitsPerDay).")
    }
    
    func getUnitsPerDay() -> Double {
        unitsPerDay
    }
    
    func changeUnitsPer7Days(newValue: Double) {
        unitsPer7Days = newValue
        
        UserDefaults.standard.set(unitsPer7Days, forKey: "weeklyLimitHasChanged")
        NotificationCenter.default.post(name: .weeklyLimitHasChanged, object: self)
        print("Weekly limit saved and = \(unitsPer7Days).")
    }
    
    func getUnitsPer7Days() -> Double {
        unitsPer7Days
    }
}

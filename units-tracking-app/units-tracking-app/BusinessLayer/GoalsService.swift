//
//   GoalsService.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 16/08/2023.
//

import Foundation


class  GoalsService: ObservableObject {
    /// Returns the number of units per day which is the max value but still within a limit.
    var unitsPerDay: Double = 5.0
    /// Returns the number of units per 7 days which is the max value but still within a limit.
    var unitsPer7Days: Double = 14.0
    
    
    init() {
        // Decode the daily limit
        guard let savedDailyLimit = UserDefaults.standard.data(forKey: "dailyLimitHasChanged") else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let loadedDailyLimit = try decoder.decode(Double.self, from: savedDailyLimit)
            unitsPerDay = loadedDailyLimit
            print("loaded!")
        } catch {
            print("Error decoding daily limit: \(error)")
        }
    }
    
    func changeUnitsPerDay(newValue: Double) {
    unitsPerDay = newValue
    }
    
    func changeUnitsPer7Days(newValue: Double) {
        unitsPer7Days = newValue
    }
}

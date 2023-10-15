//
//   GoalsService.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 16/08/2023.
//

import Foundation


class  GoalsService: ObservableObject {
    /// Returns the number of units per day which is the max value but still within a limit.
    var unitsPerDay: Double {
        return 5.0
    }
    
    /// Returns the number of units per 7 days which is the max value but still within a limit.
    var unitsPer7Days: Double {
        return 14.0
    }
}

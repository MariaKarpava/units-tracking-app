//
//  SettingsViewModel.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 02/12/2023.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    private let drinksService: DrinksService
    private let goalsService: GoalsService
    
    init(drinksService: DrinksService, goalsService: GoalsService) {
        self.drinksService = drinksService
        self.goalsService = goalsService
    }
    
    static let dayLimitRange = Array(stride(from: 1, to: 50, by: 1))
    @Published var dayLimitInPicker = dayLimitRange.first!
    
    static let weeklyLimitRange = Array(stride(from: 1, to: 50, by: 1))
    @Published var weeklyLimitInPicker = weeklyLimitRange.first!
    
    
    
}



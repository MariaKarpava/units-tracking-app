//
//  SettingsView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                DayLimitView
                WeeklyLimitView
                InfoWarningsView
                NextDayStartView
                InfoStartOfTheDay
            }
            .scrollContentBackground(.hidden)
        }
    }
    
    
    var DayLimitView: some View {
        Section() {
            Picker("Day limit", selection: $settingsViewModel.dayLimitInPicker) {
                ForEach(SettingsViewModel.dayLimitRange, id: \.self) { dayLimit in
                    Text("\(dayLimit) unit(s)")
                }
            }
        }
    }
    
    var WeeklyLimitView: some View {
        Section() {
            Picker("Weekly limit", selection: $settingsViewModel.weeklyLimitInPicker) {
                ForEach(SettingsViewModel.weeklyLimitRange, id: \.self) { weeklyLimit in
                    Text("\(weeklyLimit) unit(s)")
                }
            }
        }
    }
    
    var InfoWarningsView: some View {
        Section() {
            Text("You will get warnings if you exceed the limits or get close to do so. These limits do not affect how many units you can log.")
        }
    }
    
    var NextDayStartView: some View {
        Section() {
            DatePicker("Next day starts at", selection: $settingsViewModel.chosenTime, displayedComponents: .hourAndMinute)
        }
    }
    
    var InfoStartOfTheDay: some View {
        Section() {
            Text("Units logged before this time tomorrow will be counted as consumed today. \"Today\" means \"before going to sleep\", not \"before midnight\".")
        }
    }
    
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksService = DrinksService()
        let goalsService = GoalsService()
        return SettingsView(settingsViewModel: SettingsViewModel(drinksService: drinksService, goalsService: goalsService))
    }
}

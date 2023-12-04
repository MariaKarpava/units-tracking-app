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
            VStack {
                DayLimitView
                WeeklyLimitView
                InfoWarningsView
                NextDayStartView
                InfoStartOfTheDay
            }
        }
    }
    
    var DayLimitView: some View {
        EmptyView()
    }
    
    var WeeklyLimitView: some View {
        EmptyView()
    }
    
    var InfoWarningsView: some View {
        Text("You will get warnings if you exceed the limits or get close to do so. These limits do not affect how many units you can log.")
            .font(.settingsScreenInfoText)
    }
    
    var NextDayStartView: some View {
        EmptyView()
    }
    
    var InfoStartOfTheDay: some View {
        Text("Units logged before this time tomorrow will be counted as consumed today. \"Today\" means \"before going to sleep\", not \"before midnight\".")
            .font(.settingsScreenInfoText)
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksService = DrinksService()
        let goalsService = GoalsService()
        return SettingsView(settingsViewModel: SettingsViewModel(drinksService: drinksService, goalsService: goalsService))
    }
}

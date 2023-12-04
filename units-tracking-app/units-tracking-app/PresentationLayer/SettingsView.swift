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
            GeometryReader { geometry in
                VStack {
                    DayLimitView
                    WeeklyLimitView
                    InfoWarningsView
                    Spacer().frame(height: 50)
                    NextDayStartView
                    InfoStartOfTheDay
                }
            }.toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Settings")
                }
            }
        }
    }
    
    var DayLimitView: some View {
        HStack {
            Text("Daily limit")
            Spacer()
            Text("1")
            Text("unit(s)")
        }
        .frame(height: 50)
    }
    
    var WeeklyLimitView: some View {
        HStack {
            Text("Weekly limit")
            Spacer()
            Text("1")
            Text("unit(s)")
        }
        .frame(height: 50)
    }
    
    var InfoWarningsView: some View {
        Text("You will get warnings if you exceed the limits or get close to do so. These limits do not affect how many units you can log.")
            .font(.settingsScreenInfoText)
    }
    
    var NextDayStartView: some View {
        HStack {
            Text("Next day starts at")
            Spacer()
            Text("04:00")
        }
        .frame(height: 50)
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

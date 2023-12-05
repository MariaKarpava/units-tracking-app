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
            VStack() {
                Spacer().frame(height: 50)
                DailyLimitView
                WeeklyLimitView
                InfoWarningsView
                Spacer().frame(height: 60)
                NextDayStartView
                InfoStartOfTheDay
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Settings")
                }
            }
        }
    }
    
    var DailyLimitView: some View {
        HStack {
            Text("Daily limit")
            Spacer()
            Text("1")
            Text("unit(s)")
            Text(">")
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
    }
    
    var WeeklyLimitView: some View {
        HStack {
            Text("Weekly limit")
            Spacer()
            Text("1")
            Text("unit(s)")
            Text(">")
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
    }
    
    var InfoWarningsView: some View {
        Text("You will get warnings if you exceed the limits or get close to do so. These limits do not affect how many units you can log.")
            .font(.settingsScreenInfoText)
            .padding(.horizontal, 20)
    }
    
    var NextDayStartView: some View {
        HStack {
            Text("Next day starts at")
            Spacer()
            Text("04:00")
            Text(">")
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
    }
    
    var InfoStartOfTheDay: some View {
        Text("Units logged before this time tomorrow will be counted as consumed today. \"Today\" means \"before going to sleep\", not \"before midnight\".")
            .font(.settingsScreenInfoText)
            .padding(.horizontal, 20)
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksService = DrinksService()
        let goalsService = GoalsService()
        return SettingsView(settingsViewModel: SettingsViewModel(drinksService: drinksService, goalsService: goalsService))
    }
}

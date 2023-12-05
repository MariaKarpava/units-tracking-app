//
//  SettingsView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI


struct LimitView: View {
    var body: some View {
        VStack {
            Text(String("Change limits"))
        }
    }
}


struct SettingsView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            Spacer().frame(height: 30)
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
                            .font(.settingsScreenHeader)
                            .foregroundColor(.mainText)
                    }
                }
            }
        }
    }
    
    var DailyLimitView: some View {
        HStack {
            Text("Daily limit").foregroundColor(.mainText)
            Spacer()
            NavigationLink(destination: LimitView()) {
                Text(String(format: "%0.1f", settingsViewModel.getDailyLimit()))
                Text("unit(s)")
                Text(">")
            }.foregroundColor(.secondaryText)
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
        .font(.settingsScreenMainInfo)
        
    }
    
    var WeeklyLimitView: some View {
        HStack {
            Text("Weekly limit").foregroundColor(.mainText)
            Spacer()
            NavigationLink(destination: LimitView()) {
                Text(String(format: "%0.1f", settingsViewModel.getWeeklyLimit()))
                Text("unit(s)")
                Text(">")
            }.foregroundColor(.secondaryText)
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
        .font(.settingsScreenMainInfo)
    }
    
    var InfoWarningsView: some View {
        Text("You will get warnings if you exceed the limits or get close to do so. These limits do not affect how many units you can log.")
            .font(.settingsScreenWarningInfo)
            .foregroundColor(.mainText)
            .padding(.horizontal, 20)
    }
    
    var NextDayStartView: some View {
        HStack {
            Text("Next day starts at")
            Spacer()
            NavigationLink(destination: LimitView()) {
                Text("04:00")
                Text(">")
            }
            .foregroundColor(.secondaryText)
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
        .font(.settingsScreenMainInfo)
    }
    
    var InfoStartOfTheDay: some View {
        Text("Units logged before this time tomorrow will be counted as consumed today. \"Today\" means \"before going to sleep\", not \"before midnight\".")
            .font(.settingsScreenWarningInfo)
            .foregroundColor(.mainText)
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

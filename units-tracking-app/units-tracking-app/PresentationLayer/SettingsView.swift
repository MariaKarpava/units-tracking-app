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
        VStack {
            Spacer().frame(height: 30)
            NavigationStack {
                VStack(alignment: .leading) {
                    Spacer().frame(height: 50)
                    settingCell(title: "Daily Limit", value: "\(settingsViewModel.viewState.dailyLimit) unit(s)")
                    settingCell(title: "Weekly Limit", value: "\(settingsViewModel.viewState.weeklyLimit) unit(s)")
                    infoAboutLimits
                    Spacer().frame(height: 60)
                    settingCell(title: "Next day starts at", value: "04:00")
                    infoStartOfTheDay
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
    
    func settingCell(title: String, value: String) -> some View {
//        var units: Double = 0
//        
//        if title == "Daily Limit" {
//            units = settingsViewModel.viewState.dailyLimit
//        } else {
//            units = settingsViewModel.viewState.weeklyLimit
//        }
//        
        NavigationLink(destination: LimitView(settingsViewModel: settingsViewModel, header: title)) {
            HStack {
                Text("\(title)").foregroundColor(.mainText)
                Spacer()
                Text("\(value)")
                    .foregroundColor(.secondaryText)
                Image(systemName: "chevron.right").foregroundColor(.mainText)
            }
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
        .font(.settingsScreenMainInfo)
    }
    
    var infoAboutLimits: some View {
        Text("You will get warnings if you exceed the limits or get close to do so. These limits do not affect how many units you can log.")
            .font(.settingsScreenWarningInfo)
            .foregroundColor(.mainText)
            .frame(height: 50)
            .padding(.horizontal, 20)
    }
    
    var infoStartOfTheDay: some View {
        Text("Units logged before this time tomorrow will be counted as consumed today. \"Today\" means \"before going to sleep\", not \"before midnight\".")
            .font(.settingsScreenWarningInfo)
            .foregroundColor(.mainText)
            .padding(.horizontal, 20)
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let goalsService = GoalsService()
        let drinksService = DrinksService(goalsService: goalsService)
        return SettingsView(settingsViewModel: SettingsViewModel(drinksService: drinksService, goalsService: goalsService))
    }
}

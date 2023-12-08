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
                    settingCell(settingTitle: "Daily limit", settingValue: "unit(s)", showUnits: true)
                    settingCell(settingTitle: "Weekly limit", settingValue: "unit(s)", showUnits: true)
                    infoWarningsView
                    Spacer().frame(height: 60)
                    settingCell(settingTitle: "Next day starts at", settingValue: "04:00", showUnits: false)
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
    
    func settingCell(settingTitle: String, settingValue: String, showUnits: Bool) -> some View {
        NavigationLink(destination: LimitView()) {
            HStack {
                Text("\(settingTitle)").foregroundColor(.mainText)
                Spacer()
                HStack {
                    if showUnits {
                        Text(String(format: "%0.1f", settingsViewModel.getDailyLimit()))
                    }
                    Text("\(settingValue)")
                }
                .foregroundColor(.secondaryText)
                Image(systemName: "chevron.right").foregroundColor(.mainText)
            }
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
        .font(.settingsScreenMainInfo)
    }
    
    var infoWarningsView: some View {
        Text("You will get warnings if you exceed the limits or get close to do so. These limits do not affect how many units you can log.")
            .font(.settingsScreenWarningInfo)
            .foregroundColor(.mainText)
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
        let drinksService = DrinksService()
        let goalsService = GoalsService()
        return SettingsView(settingsViewModel: SettingsViewModel(drinksService: drinksService, goalsService: goalsService))
    }
}

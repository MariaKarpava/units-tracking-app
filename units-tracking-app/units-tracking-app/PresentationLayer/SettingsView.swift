//
//  SettingsView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI


struct SettingsView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    let goalsService: GoalsService
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer().frame(height: 40)
                Spacer().frame(height: 50)
                settingCell(title: "Daily Limit", value: "\(settingsViewModel.viewState.dailyLimit) unit(s)", limitType: .daily)
                settingCell(title: "Weekly Limit", value: "\(settingsViewModel.viewState.weeklyLimit) unit(s)", limitType: .weekly)
                infoAboutLimits
                Spacer().frame(height: 60)
                settingCell(title: "Next day starts at", value: "04:00", limitType: .daily)
                infoStartOfTheDay
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Settings")
                        .font(.settingsScreenTitle)
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
    
    func settingCell(title: String, value: String, limitType: LimitSettingViewModel.LimitType) -> some View {
        let vm = LimitSettingViewModel(goalsService: goalsService, limitType: limitType)
        return NavigationLink(destination: LimitSettingView(limitSettingViewModel: vm)) {
            HStack {
                Text("\(title)").foregroundColor(.accentColor)
                Spacer()
                Text("\(value)")
                    .foregroundColor(.secondaryText)
                Image(systemName: "chevron.right").foregroundColor(.accentColor)
            }
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
        .font(.settingsScreenMainInfo)
        .onAppear {
            settingsViewModel.updateViewState()
        }
    }
    
    var infoAboutLimits: some View {
        Text("You will get warnings if you exceed the limits or get close to do so. These limits do not affect how many units you can log.")
            .font(.settingsScreenWarningInfo)
            .foregroundColor(.accentColor)
            .frame(height: 50)
            .padding(.horizontal, 20)
    }
    
    var infoStartOfTheDay: some View {
        Text("Units logged before this time tomorrow will be counted as consumed today. \"Today\" means \"before going to sleep\", not \"before midnight\".")
            .font(.settingsScreenWarningInfo)
            .foregroundColor(.accentColor)
            .padding(.horizontal, 20)
    }

}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let goalsService = GoalsService()
        return SettingsView(
            settingsViewModel: SettingsViewModel(goalsService: goalsService),
            goalsService: goalsService
        )
    }
}

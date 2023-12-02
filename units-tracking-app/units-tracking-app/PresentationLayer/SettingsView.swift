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
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksService = DrinksService()
        let goalsService = GoalsService()
        return SettingsView(settingsViewModel: SettingsViewModel(drinksService: drinksService, goalsService: goalsService))
    }
}

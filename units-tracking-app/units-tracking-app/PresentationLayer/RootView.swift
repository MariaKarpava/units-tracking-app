//
//  ContentView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

    
struct RootView: View {
    var drinksService: DrinksService
    var goalsService: GoalsService
    
    var body: some View {
        TabView {
            let addNewDrinkVM = AddNewDrinkViewModel(drinksService: drinksService)
            
            HomeView(homeViewModel: HomeViewModel(drinksService: drinksService, goalsService: goalsService)).tabItem {
                Label("Home", systemImage: "house").foregroundColor(.accentColor)
            }
            StatisticsView()
                .tabItem {
                Label("Statistics", systemImage: "waveform").foregroundColor(.accentColor)
            }
            AddNewDrinkView(viewModel: addNewDrinkVM)
                .tabItem {
                Label("Add New Drink", systemImage: "plus.circle").foregroundColor(.accentColor)
            }
            HistoryView().tabItem {
                Label("History", systemImage: "book").foregroundColor(.accentColor)
            }
            SettingsView().tabItem {
                Label("Settings", systemImage: "person.crop.circle.fill").foregroundColor(.accentColor)
            }
        }
    }
}


struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let goalsService = GoalsService()
        let drinksService = DrinksService()
        RootView(drinksService: drinksService, goalsService: goalsService)
    }
}

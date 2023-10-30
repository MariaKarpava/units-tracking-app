//
//  ContentView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

    
struct RootView1: View {
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
                    Label("Stats", systemImage: "chart.xyaxis.line").foregroundColor(.accentColor)
            }
            AddNewDrinkView(viewModel: addNewDrinkVM)
                .tabItem {
                Image("AddButton").foregroundColor(.accentColor)
            }
            HistoryView().tabItem {
                Label("History", systemImage: "list.bullet").foregroundColor(.accentColor)
            }
            SettingsView().tabItem {
                Label("Settings", systemImage: "gearshape").foregroundColor(.accentColor)
            }
        }
    }
}


struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let goalsService = GoalsService()
        let drinksService = DrinksService()
        
        RootView1(drinksService: drinksService, goalsService: goalsService)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        RootView1(drinksService: drinksService, goalsService: goalsService)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}

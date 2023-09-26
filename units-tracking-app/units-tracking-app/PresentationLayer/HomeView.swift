//
//  HomeView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 06/09/2023.
//

import SwiftUI

struct HomeView: View {
    let homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 225)
            if homeViewModel.colorForUnits == Color.red {
                Image("WarningSymbol")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 122)
                Text("You have reached your \n drinking limit today.")
                    .foregroundColor(Color("SecondaryTextColor"))
                    .font(.homeScreenText)
                    .multilineTextAlignment(.center)
                    .frame(height: 136)
                
            } else {
                Text(String(format: "%.1f", homeViewModel.getUnitsRemainingForToday))
                    .foregroundColor(homeViewModel.colorForUnits)
                    .font(.homeScreenUnits)
                    .frame(height: 129)
                Text("Units remaining \n for today")
                    .foregroundColor(Color("SecondaryTextColor"))
                    .font(.homeScreenText)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            Text("Why?")
                .underline()
                .foregroundColor(.accentColor)
                .font(.homeScreenInfoText)
                .frame(height: 96)
            Spacer()
                .frame(height: 290)
            
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksService = DrinksService()
        let goalsService = GoalsService()
        let homeViewModel = HomeViewModel(drinksService: drinksService, goalsService: goalsService)
        
        return HomeView(homeViewModel: homeViewModel)
    }
}

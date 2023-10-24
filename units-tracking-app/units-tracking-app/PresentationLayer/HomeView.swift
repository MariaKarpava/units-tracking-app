//
//  HomeView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 06/09/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 225)
            switch homeViewModel.viewState.remainingUnitsIndication {
            case .warning:
                Image("WarningSymbol")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 122)
            case .exactNumber(let units, let color):
                Text(String(format: "%.1f", units))
                    .foregroundColor(color)
                    .font(.homeScreenUnits)
                    .frame(height: 129)
            }

            Text(homeViewModel.viewState.text)
                .foregroundColor(.secondaryText)
                .font(.homeScreenText)
                .multilineTextAlignment(.center)
                .frame(height: 136)
            Button {
                homeViewModel.whyButtonTapped()
            } label: {
                Text("Why?")
                    .frame(height: 96)
                    .underline()
                    .foregroundColor(.accent)
                    .font(.homeScreenInfoButton)
            }
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

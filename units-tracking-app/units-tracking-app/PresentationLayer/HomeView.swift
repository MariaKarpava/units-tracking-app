//
//  HomeView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 06/09/2023.
//

import SwiftUI

struct HomeView: View {
    private let drinksService: DrinksService
    private let goalsService: GoalsService
    
    init(drinksService: DrinksService, goalsService: GoalsService) {
        self.drinksService = drinksService
        self.goalsService = goalsService
    }
    
    func colorForUnits(units: Double) -> Color {
        if units >= goalsService.getUnitsPerDay() {
            return Color("MainTextColor")
        } else {
            return Color("CustomOrange")
        }
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Text(String(format: "%.1f", drinksService.unitsRemainingForToday))
                .foregroundColor(colorForUnits(units: drinksService.unitsRemainingForToday))
                .font(.homeScreenUnits)
                .frame(height: 129)
            Text("Units remaining \n for today")
                .foregroundColor(Color("SecondaryTextColor"))
                .font(.homeScreenText)
                .multilineTextAlignment(.center)
            Spacer()
            Text("Why?")
                .underline()
                .foregroundColor(.accentColor)
                .font(.homeScreenInfoText)
            Spacer()
            Spacer()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(drinksService: DrinksService(), goalsService: GoalsService())
    }
}

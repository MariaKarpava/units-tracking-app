//
//  HomeView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 06/09/2023.
//

import SwiftUI

struct HomeView: View {
    private let drinksService: DrinksService
    
    init(drinksService: DrinksService) {
        self.drinksService = drinksService
    }
    
    var body: some View {
        VStack {
            
            
            Spacer()
            Spacer()
            Text("UnitsConsumedToday: \(drinksService.unitsConsumedToday)")
            Text("UnitsConsumedToday: \(drinksService.unitsConsumedWithinLast7Days)")

            
            Text("12.5")
                .foregroundColor(Color("MainTextColor"))
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
        HomeView(drinksService: DrinksService())
    }
}

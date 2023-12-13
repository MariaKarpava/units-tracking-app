//
//  DailyLimit.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 13/12/2023.
//

import SwiftUI


struct DailyLimit: View {
    var body: some View {
       NavigationStack {
            VStack(alignment: .leading) {
                VStack {
                    infoText
                    Spacer().frame(height: 140)
                    unitsIncrement
                }
            }.navigationTitle("Daily Limit")
               .toolbar {
                   Button("Save") {
                       
                   }
               }
        }
    }
    
    var infoText: some View {
        Text("""
            According to the NHS, males should 
            not exceed a daily limit of 8 units,
            while for females the value is 6 units. 
            
            Note: there is no safe amount of
            alcohol. The more alcohol you
            consume, the higher are the risks.
            """)
    }
    
    var unitsIncrement: some View {
        HStack {
            roundSquare
            VStack {
                Text("6")
                Text("unit(s)")
            }.frame(width: 120, height: 64)
            roundSquare
        }
    }
    
    var roundSquare: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 2)
            .frame(width: 64, height: 64)
    }
}




#Preview {
    DailyLimit()
}

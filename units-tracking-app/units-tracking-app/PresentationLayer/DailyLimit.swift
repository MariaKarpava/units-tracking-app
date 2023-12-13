//
//  DailyLimit.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 13/12/2023.
//

import SwiftUI


struct DailyLimit: View {
    
    var body: some View {
        VStack {
            Spacer().frame(height: 30)
            NavigationStack {
                VStack(alignment: .leading) {
                    Text("Daily Limit")
                        .font(.settingsScreenHeader)
                        .foregroundColor(.mainText)
                    VStack {
                        Spacer().frame(height: 60)
                        infoText
                        Spacer().frame(height: 140)
                        HStack {
                            Button {
                                
                            } label: {
                                addCustomStepperButton(sign: "-")
                            }
                            unitsIncrement
                            Button {
                                
                            } label: {
                                addCustomStepperButton(sign: "+")
                            }
                        }
                        
                        Spacer()
                    }
                    
                }
                .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button("Save") {
                          print("save")
                       }
                   }
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
        VStack {
            Text("6")
            Text("unit(s)")
        }.frame(width: 120, height: 64)
    }
    
    func addCustomStepperButton(sign: String) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 2)
            .frame(width: 64, height: 64)
            .overlay(Text(sign))
    }
    
    
}




#Preview {
    DailyLimit()
}

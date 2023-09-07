//
//  HomeView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 06/09/2023.
//

import SwiftUI

struct HomeView: View {
    init() {
        for fontFamily in UIFont.familyNames {
            for font in UIFont.fontNames(forFamilyName: fontFamily) {
                print("--\(font)")
            }
        }
        
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Text("12.5")
                .foregroundColor(Color("MainTextColor"))
                .font(.homeScreenUnits)
            Text("Units remaining for today")
                .foregroundColor(Color("SecondaryTextColor"))
                .font(.homeScreenText)
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
        HomeView()
    }
}

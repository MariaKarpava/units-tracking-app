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
            Text("12.5").font(.largeTitle).bold()
            Text("Units remaining for today").font(.title2)
            Spacer()
            Text("Why?").underline()
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

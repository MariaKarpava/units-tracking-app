//
//  CustomTabBar.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 14/09/2023.
//

import SwiftUI

struct CustomTabBar: View {
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .bottom, spacing: 35) {
                Button {
                    // Switch to Home
                } label: {
                    VStack(alignment: .center, spacing: 5) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 23))
                            .border(.red)
                        Text("Home")
                            .font(.system(size: 10))
                            
                    }
                    .frame(width: 48, height: 40, alignment: .center)
                    .border(.green)
                }
                
                Button {
                    // Switch to
                } label: {
                    VStack(alignment: .center, spacing: 5) {
                        Image(systemName: "chart.xyaxis.line")
                            .font(.system(size: 23))
                        Text("Stats")
                            .font(.system(size: 10))
                    }
                    .frame(width: 48, height: 40, alignment: .center)
                    .border(.green)
                }
                
                Button {
                    // Switch to
                } label: {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(colors: [Color("AddButtonUpperColor"), Color("AddButtonBottomColor")], startPoint: .top, endPoint: .bottom)
                                )
                            .frame(width: 64, height: 64)
                                
                        Image(systemName: "plus")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25))
                    }
                    .border(.green)
                }
                
                Button {
                    // Switch to
                } label: {
                    VStack(alignment: .center, spacing: 5) {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 23))
                            .border(.red)
                        Text("History")
                            .font(.system(size: 10))
                    }
                    .frame(width: 48, height: 40, alignment: .center)
                    .border(.green)
                }
                
                Button {
                    // Switch to
                } label: {
                    VStack(alignment: .center, spacing: 5) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 23))
                            .border(.red)
                        Text("Setings")
                            .font(.system(size: 10))
                    }
                    .frame(width: 48, height: 40, alignment: .center)
                    .border(.green)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}






struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")

        CustomTabBar()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}

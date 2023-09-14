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
            HStack {
                Button {
                    // Switch to Home
                } label: {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                
                Button {
                    // Switch to
                } label: {
                    VStack {
                        Image(systemName: "chart.xyaxis.line")
                        Text("Stats")
                    }
                }
                
                Button {
                    // Switch to
                } label: {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(colors: [.white, .blue], startPoint: .top, endPoint: .bottom)
                                )
                            .frame(width: 64, height: 64)
                                
                        Image(systemName: "plus")
                            .foregroundColor(Color.white)
                            .frame(width: 60, height: 60)
                            
                    }
                }
                
                Button {
                    // Switch to
                } label: {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("History")
                    }
                }
                
                Button {
                    // Switch to
                } label: {
                    VStack {
                        Image(systemName: "gearshape")
                        Text("Setings")
                    }
                }
                
                

            }.frame(height: 82)

        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}

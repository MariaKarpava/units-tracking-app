//
//  CustomTabBar.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 14/09/2023.
//

import SwiftUI
import CoreGraphics


struct TestScreen: View {
    var body: some View {
        VStack {
            Text("Hello World")
            Spacer()
            CustomTabBar()
        }
    }
}



struct CustomTabBar: View {
    @State private var tabBarHeight: CGFloat = 0
    @State private var tabBarWidth: CGFloat = 0
    
    var body: some View {
        
        GeometryReader { geometry0 in
            VStack {
                Text("Tab Bar Height: \(tabBarHeight)")
                Text("Tab Bar Width: \(tabBarWidth)")
                
                Spacer()
                
                GeometryReader { geometry in
                    
                    TopBorderVectorView().offset(y: 17)
                    
                        HStack(alignment: .bottom, spacing: 0) {
                            Spacer(minLength: 0)
                            Button(action: {
                                // Switch to Home
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "house.fill")
                                        .font(.system(size: 23))
                                        .border(Color.red)
                                    Text("Home")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                            }
                            
                            Button(action: {
                                // Switch to Stats
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "chart.xyaxis.line")
                                        .font(.system(size: 23))
                                    Text("Stats")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                            }
                            
                            Button(action: {
                                // Add Button Action
                            }) {
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
                            }.offset(y: -10)
                            
                            Button(action: {
                                // Switch to History
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "list.bullet")
                                        .font(.system(size: 23))
                                        .border(Color.red)
                                    Text("History")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                            }
                            
                            Button(action: {
                                // Switch to Settings
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "gearshape")
                                        .font(.system(size: 23))
                                        .border(Color.red)
                                    Text("Settings")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                            }
                            Spacer(minLength: 0)
                        }
                        .padding()
    //                    .background(Color.blue)
    //                    .opacity(0.2)
    //                    .border(Color.blue)
                        .onAppear {
                            tabBarHeight = geometry.size.height
                            tabBarWidth = geometry.size.width
                    }
                }
                .frame(height: 77)
            }
        }
    }
}





struct TopBorderVector: View {
    var body: some View {
        EmptyView()
    }
}




struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        TestScreen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")

        TestScreen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}

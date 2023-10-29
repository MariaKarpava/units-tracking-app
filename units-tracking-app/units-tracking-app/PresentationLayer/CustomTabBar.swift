//
//  CustomTabBar.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 14/09/2023.
//

import SwiftUI
import CoreGraphics


struct HistoryView2: View {
    var body: some View {
        Text("History View 2")
    }
}

struct AddView2: View {
    var body: some View {
        Text("Add View 2")
    }
}


enum TabbedItems: Int, CaseIterable {
    case home
    case stats
    case history
    case settings
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .stats:
            return "Stats"
        case .history:
            return "History"
        case .settings:
            return "Settings"
        }
    }
    
    var iconName: String{
            switch self {
            case .home:
                return "house"
            case .stats:
                return "chart.xyaxis.line"
            case .history:
                return "list.bullet"
            case .settings:
                return "gearshape"
            }
        }
}


struct TestScreen: View {
    @State var selectedTab = 0
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom){
                TabView(selection: $selectedTab) {
                    HomeView(homeViewModel: homeViewModel).tag(0)
                    StatisticsView().tag(1)
                    HistoryView2().tag(2)
                    SettingsView().tag(3)
                }
            }
            ZStack{
                    HStack{
                        ForEach((TabbedItems.allCases), id: \.self){ item in
                            Button{
                                selectedTab = item.rawValue
                            } label: {
                                CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                            }
                        }
                    }
                    .padding(6)
                }
                .frame(height: 70)
                .background(.purple.opacity(0.2))
                .cornerRadius(35)
                .padding(.horizontal, 26)
        }
    }
}

extension TestScreen{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        VStack(alignment: .center, spacing: 5){
            Image(systemName: imageName)
                .font(.system(size: 23))
                .foregroundColor(isActive ? .accent : .gray)
            Text(title)
                .font(.system(size: 10))
                .frame(maxWidth: .infinity)
                .foregroundColor(isActive ? .accent : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}















struct CustomTabBar: View {
    @State private var tabBarHeight: CGFloat = 0
    @State private var tabBarWidth: CGFloat = 0
    
    
    var body: some View {
        GeometryReader { geometry0 in
            VStack {
                Spacer()
                GeometryReader { geometry in
                    
                    TopBorderVectorView().offset(y: 35)
                    
                        HStack(alignment: .center, spacing: 0) {
                            Spacer(minLength: 0)
                            Button(action: {
                                // Switch to Home
                                
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "house")
                                        .font(.system(size: 23))
//                                        .border(Color.red)
                                    Text("Home")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.black)
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
                                .foregroundColor(Color.black)
                            }
                            
                            Button(action: {
                                // Add Button Action
                            }) {
                                ZStack(alignment: .center) {
                                    Circle()
                                        .fill(
                                            LinearGradient(colors: [Color.addButtonTopColor, Color.addButtonBottomColor], startPoint: .top, endPoint: .bottom)
                                        )
                                        .frame(width: 64, height: 64)
                                                    
                                    Image(systemName: "plus")
                                        .foregroundColor(Color.white)
//                                        .font(.system(size: 27))
                                        .font(Font.system(size: 30, weight: .medium))
                                        
                                }
                            } .offset(y: -13)
                            
                            Button(action: {
                                // Switch to History
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "list.bullet")
                                        .font(.system(size: 23))
//                                        .border(Color.red)
                                    Text("History")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.black)
                            }
                            
                            Button(action: {
                                // Switch to Settings
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "gearshape")
                                        .font(.system(size: 23))
//                                        .border(Color.red)
                                    Text("Settings")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.black)
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
        let drinksService = DrinksService()
        let goalsService = GoalsService()
        let homeViewModel = HomeViewModel(drinksService: drinksService, goalsService: goalsService)
        
        TestScreen(homeViewModel: homeViewModel)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")

        TestScreen(homeViewModel: homeViewModel)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}

// MainTabView.swift by mac 09.09.2026

import Foundation
import SwiftUI

struct MainTabView: View {
    @StateObject var mainRouter = Router()
//    @StateObject var listRouter = Router()
    
    @StateObject var mainViewModel = MainViewModel()
    @StateObject var listViewModel = ListViewModel(currencies: nil)

    var body: some View {
        TabView(selection: $mainRouter.selectedTab) {
            NavigationStack(path: $mainRouter.path) {
                MainView(router: mainRouter, mainViewModel: mainViewModel)
            }
            .tabItem { Label("Main", systemImage: "rublesign.arrow.trianglehead.counterclockwise.rotate.90") }
            .tag(Tab.main)

            NavigationStack(path: $mainRouter.path) {
                ZStack {
                    Color("Neutral")
                        .ignoresSafeArea()
                    
                    VStack(alignment: .center) {
                        ListViewWrapper(listViewModel: listViewModel) { _ in }
                    }
                    .frame(width: 370, height: 595)
                    .background(Color("Secondary_First"))
                    .cornerRadius(16)
                }
                .navigationTitle("All currencies")
                .navigationBarTitleDisplayMode(.large)
            }
            .tabItem { Label("List", systemImage: "book.pages") }
            .tag(Tab.list)
        }
        .environmentObject(mainRouter)
        .tint(Color("Accent"))
    }
}

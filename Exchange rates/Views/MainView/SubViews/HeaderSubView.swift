// HeaderSubView.swift by mac 09.09.2026

import Foundation
import SwiftUI

struct HeaderSubView: View {
    @ObservedObject var mainViewModel: MainViewModel

    @EnvironmentObject var router: Router
    
    var body: some View {
        HStack {
            Text("Popular today")
                .font(.system(size: 28))
                .fontWeight(.bold)
                .foregroundColor(Color("Text_Primary_First"))

            Spacer()

            Button(action: {
                if mainViewModel.dataDownloaded {
                    router.selectedTab = .list
                } else {
                    print("No internet conection")
                }
            }) {
                Text("View all ›")
                    .font(.system(size: 28))
                    .fontWeight(.semibold)
                    .foregroundColor(mainViewModel.dataDownloaded ? Color("Accent") : Color("Download"))
            }
        }
    }
}

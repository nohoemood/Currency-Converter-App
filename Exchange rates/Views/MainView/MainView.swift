// ContentView.swift by mac 07.09.2026

import SwiftUI

struct MainView: View {
    @StateObject var router: Router
    @StateObject var mainViewModel: MainViewModel

    @State var showListView: Bool = false

    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                Color("Neutral")
                    .ignoresSafeArea()

                GeometryReader { geometry in
                    VStack(spacing: 16) {
                        // MARK: - Сonversion view
                        ConversionSubView(
                            dataDownloaded: $mainViewModel.dataDownloaded,
                            rubleAmount: $mainViewModel.rubleAmount,
                            currencyAmount: $mainViewModel.currencyAmount,
                            rublePlaceholder: mainViewModel.rubleTextFieldPlaceholder,
                            currencyPlaceholder: mainViewModel.currencyTextFieldPlaceholder,
                            selectedCurrency: mainViewModel.selectedCurrency
                        ) {
                            showListView = true
                            print("LIST VIEW is presented")
                        }
                        .frame(width: 370, height: 260)
                        .background(Color("Secondary_First"))
                        .cornerRadius(16)

                        // MARK: - Currency list
                        VStack(spacing: 16) {
                            HeaderSubView(mainViewModel: mainViewModel)
                                .padding(.horizontal, 16)
                                .padding(.top, 16)

                            CurrencyRowSubView(mainViewModel: mainViewModel)
                                .frame(width: 338, height: 228)
                                .padding(.horizontal, 16)
                            
                            Spacer()
                        }
                        .frame(width: 370, height: 320, alignment: .leading)
                        .background(Color("Secondary_First"))
                        .cornerRadius(16)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .ignoresSafeArea(.keyboard)
            }
            .ignoresSafeArea(.keyboard)
        }
        .navigationTitle("Exchange rates")
        .onTapGesture {
            hideKeyboard()
        }
        // MARK: - Error handling
        .task {
            do {
                try await mainViewModel.fetchCurrencies()
            } catch APIError.invalidURL {
                print("Invalid URL")
            } catch APIError.invalidResponse {
                print("Invalid response")
            } catch APIError.invalidData {
                print("Invalid data")
            } catch {
                print("Enxcepted error")
            }
        }
        // MARK: - Sheet
        .sheet(isPresented: $showListView) {
            let listVM = ListViewModel(currencies: mainViewModel.allCurrencies)
            
            NavigationStack {
                ListViewWrapper(listViewModel: listVM) { currency in
                    mainViewModel.selectCurrency(by: currency)
                    
                    mainViewModel.currencyAmount = ""
                    mainViewModel.rubleAmount = ""
                    
                    showListView = false
                }
                .ignoresSafeArea()
                .navigationTitle("Select a currency")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            showListView = false
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(Color("Text_Primary_First") /*.red*/)
                        }
                    }
                }
                .toolbarBackground(.hidden, for: .navigationBar)
            }
            .interactiveDismissDisabled(true)
        }
    }
}

// #Preview {
//    ContentView()
// }

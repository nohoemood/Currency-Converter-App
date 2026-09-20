// CurrencyRowSubView.swift by mac 10.09.2026

import Foundation
import SwiftUI

struct CurrencyRowSubView: View {
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            if !mainViewModel.isLoading && mainViewModel.dataDownloaded {
                // MARK: - Main view
                ForEach(mainViewModel.popularCurrencies) { currency in
                    HStack {
                        ZStack {
                            currency.symbol
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipped()
                                .tint(Color("Accent"))
//                                .blendMode(.multiply)
                            
                            Circle()
                                .stroke(Color("Accent"), lineWidth: 3)
                                .frame(width: 55, height: 55)
                        }
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text(currency.enName)
                                .foregroundColor(Color("Text_Primary_First"))
                                .font(.system(size: 22))
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .frame(maxWidth: 165, alignment: .leading)
                            
                            HStack {
                                Text(currency.charCode)
                                    .foregroundColor(Color("Text_Primary_Second"))
                                    .font(.system(size: 18))
                                    .fontWeight(.medium)
                                Text(String(format: "%.4f", currency.value))
                                    .foregroundColor(Color("Text_Primary_First"))
                                    .font(.system(size: 18))
                                    .fontWeight(.medium)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 5) {
                            Text(currency.countryName)
                                .foregroundColor(Color("Text_Primary_First"))
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .frame(maxWidth: 95, alignment: .trailing)
                            
                            currency.flag
                                .resizable()
                                .scaledToFill()
                                .frame(width: 38, height: 20)
                                .clipped()
                                .cornerRadius(3)
                        }
                    }
                    .frame(height: 70)
                }
            } else if !mainViewModel.dataDownloaded {
                // MARK: - Error view
                Image(systemName: "network.slash")
                    .font(.system(size: 103))
                
                VStack(spacing: 0) {
                    Text("No internet connection")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Text_Primary_First"))
                    
                    Text("Try turning off your VPN or Proxy")
                        .font(.system(size: 18))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Text_Primary_Second"))
                }
                
                Button(action: {
                    Task {
                        do {
                            try await mainViewModel.fetchCurrencies()
                        } catch {
                            print("Enxcepted error")
                        }
                    }
                }) {
                    Text("Reload data")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Accent"))
                }
                
            } else {
                // MARK: - Dowload view
                ForEach(0 ..< 3, id: \.self) { _ in
                    HStack {
                        Circle()
                            .fill(Color("Download"))
                            .frame(width: 55, height: 55)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color("Download"))
                                .frame(width: 186, height: 26)
                            
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color("Download"))
                                .frame(width: 159, height: 26)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 5) {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color("Download"))
                                .frame(width: 67, height: 26)
                            
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color("Download"))
                                .frame(width: 38, height: 20)
                        }
                    }
                    .frame(height: 70)
                }
            }
        }
    }
}

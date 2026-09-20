// ConversionSubView.swift by mac 09.09.2026

import Foundation
import SwiftUI

struct ConversionSubView: View {
    
    @Binding var dataDownloaded: Bool
    
    @Binding var rubleAmount: String
    @Binding var currencyAmount: String

    /// Text Fields
    var rublePlaceholder: String
    var currencyPlaceholder: String
    @FocusState private var isRubleFocused: Bool
    @FocusState private var isCurrencyFocused: Bool

    var selectedCurrency: Currency?
    var buttonTupped: () -> Void
    
    var body: some View {
        VStack {
            // MARK: -  First rubles TextField
            ZStack(alignment: .leading) {
                TextField("", text: $rubleAmount)
                    .focused($isRubleFocused)
                    .font(.system(size: 24))
                    .foregroundColor(isRubleFocused ? Color("Text_Primary_First") : Color("Text_Primary_Second"))
                    .fontWeight(.medium)
                    .padding(.leading, 16)
                    .textFieldStyle(.plain)
                    .frame(width: 338, height: 60)
                    .background(Color("Secondary_Second"))
                    .cornerRadius(26)
                    .tint(Color("Accent"))
                    .overlay(
                        ZStack {
                            RightHalfRoundedRectangleAnimate(cornerRadius: 26)
                                .trim(from: 0, to: isRubleFocused ? 1 : 0)
                                .stroke(Color("Accent"), lineWidth: 3)
                                
                            RightHalfRoundedRectangleAnimate(cornerRadius: 26)
                                .trim(from: 0, to: isRubleFocused ? 1 : 0)
                                .stroke(Color("Accent"), lineWidth: 3)
                                .scaleEffect(x: -1, y: 1)
                        }
                        .animation(.easeInOut(duration: 0.6), value: isRubleFocused)
                    )
                    .keyboardType(.numberPad)
                    .onChange(of: rubleAmount) { _, newValue in
                        let filtered = newValue.filter { $0.isNumber || $0 == "." || $0 == "," }
                        if newValue != filtered {
                            rubleAmount = filtered
                        }
                    }
                    .disabled(selectedCurrency == nil || dataDownloaded == false)

                // MARK: -  First rubles placeholder
                let isFloating = isRubleFocused || !rubleAmount.isEmpty
                Text(rublePlaceholder)
                    .font(.system(size: isFloating ? 22 : 28))
                    .fontWeight(isRubleFocused ? .medium : .regular)
                    .foregroundColor(isRubleFocused ? Color("Accent") : Color("Text_Primary_Second"))
                    .padding(.horizontal, isFloating ? 6 : 0)
                    .padding(.vertical, isFloating ? 3 : 0)
                    .background(isFloating ? Color("Secondary_First") : Color.clear)
                    .cornerRadius(26)
                    .offset(x: isFloating ? 20 : 16, y: isFloating ? -34 : 0)
                    .allowsHitTesting(false)
                    .animation(.easeInOut(duration: 0.2), value: isRubleFocused)
                    .animation(.easeInOut(duration: 0.2), value: rubleAmount.isEmpty)
            }
            .frame(width: 338, height: 60)
            
            // MARK: - Selected currency label & Choice buttom
            HStack {
                Text(selectedCurrency == nil ? "Select" : "" )
                    .font(.system(size: 36))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Text_Primary_First"))
                
                Button(action: {
                    if dataDownloaded {
                        buttonTupped()
                    } else {
                        print("No internet conection")
                    }
                }) {
                    Text(selectedCurrency == nil ? "currency ›" : "\(selectedCurrency!.enName) ›")
                        .font(.system(size: 36))
                        .fontWeight(.semibold)
                        .foregroundColor(dataDownloaded ? Color("Accent") : Color("Download"))
                }
            }
            
            // MARK: - Second currency TextField
            ZStack(alignment: .leading) {
                TextField("", text: $currencyAmount)
                    .focused($isCurrencyFocused)
                    .font(.system(size: 24))
                    .foregroundColor(isCurrencyFocused ? Color("Text_Primary_First") : Color("Text_Primary_Second"))
                    .fontWeight(.medium)
                    .padding(.leading, 16)
                    .textFieldStyle(.plain)
                    .frame(width: 338, height: 60)
                    .background(Color("Secondary_Second"))
                    .cornerRadius(26)
                    .tint(Color("Accent"))
                    .overlay(
                        ZStack {
                            RightHalfRoundedRectangleAnimate(cornerRadius: 26)
                                .trim(from: 0, to: isCurrencyFocused ? 1 : 0)
                                .stroke(Color("Accent"), lineWidth: 3)
                
                            RightHalfRoundedRectangleAnimate(cornerRadius: 26)
                                .trim(from: 0, to: isCurrencyFocused ? 1 : 0)
                                .stroke(Color("Accent"), lineWidth: 3)
                                .scaleEffect(x: -1, y: 1)
                        }
                        .animation(.easeInOut(duration: 0.6), value: isCurrencyFocused)
                    )
                    .keyboardType(.numberPad)
                    .onChange(of: currencyAmount) { _, newValue in
                        let filtered = newValue.filter { $0.isNumber || $0 == "." || $0 == "," }
                        if newValue != filtered {
                            currencyAmount = filtered
                        }
                    }
                    .disabled(selectedCurrency == nil || dataDownloaded == false)

                // MARK: -  Second currecny placeholder
                let isFloating = isCurrencyFocused || !currencyAmount.isEmpty
                Text(currencyPlaceholder)
                    .font(.system(size: isFloating ? 22 : 28))
                    .fontWeight(isCurrencyFocused ? .medium : .regular)
                    .foregroundColor(isCurrencyFocused ? Color("Accent") : Color("Text_Primary_Second"))
                    .padding(.horizontal, isFloating ? 6 : 0)
                    .padding(.vertical, isFloating ? 3 : 0)
                    .background(isFloating ? Color("Secondary_First") : Color.clear)
                    .cornerRadius(26)
                    .offset(x: isFloating ? 20 : 16, y: isFloating ? -34 : 0)
                    .allowsHitTesting(false)
                    .animation(.easeInOut(duration: 0.2), value: isCurrencyFocused)
                    .animation(.easeInOut(duration: 0.2), value: currencyAmount.isEmpty)
            }
            .frame(width: 338, height: 60)
        }
    }
}

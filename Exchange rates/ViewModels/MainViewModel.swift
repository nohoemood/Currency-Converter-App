// MainViewModel.swift by mac 09.09.2026

import Combine
import Foundation

class MainViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var dataDownloaded: Bool = false
    
    @Published var allCurrencies: [Currency] = []
    var popularCurrencies: [Currency] {
        allCurrencies.filter { ["USD", "EUR", "GBP"].contains($0.charCode) }
    }
    
    @Published var selectedCurrency: Currency? = nil
    
    // MARK: - TextField's properties
    private var isUpdating = false

    @Published var rubleAmount: String = "" {
        didSet {
            guard rubleAmount != oldValue else { return }
            guard !isUpdating else { return }
            updateCurrencyAmount()
        }
    }

    @Published var currencyAmount: String = "" {
        didSet {
            guard currencyAmount != oldValue else { return }
            guard !isUpdating else { return }
            updateRubleAmount()
        }
    }
        
    private func updateCurrencyAmount() {
        let cleanText = rubleAmount.replacingOccurrences(of: ",", with: ".")
            
        if let rubValue = Double(cleanText), let currency = selectedCurrency {
            isUpdating = true
            let result = rubValue / currency.value
            currencyAmount = String(format: "%.2f", result)
            isUpdating = false
        } else if rubleAmount.isEmpty {
            isUpdating = true
            currencyAmount = ""
            isUpdating = false
        }
    }

    private func updateRubleAmount() {
        let cleanText = currencyAmount.replacingOccurrences(of: ",", with: ".")
            
        if let foreignValue = Double(cleanText), let currency = selectedCurrency {
            isUpdating = true
            let result = foreignValue * currency.value
            rubleAmount = String(format: "%.2f", result)
            isUpdating = false
        } else if currencyAmount.isEmpty {
            isUpdating = true
            rubleAmount = ""
            isUpdating = false
        }
    }
    
    let rubleTextFieldPlaceholder = "Rubles"
    @Published var currencyTextFieldPlaceholder = "Currency"
    
    // MARK: - Init
    init() { /* getData() */ }

    func selectCurrency(by currency: Currency) {
        selectedCurrency = currency
        currencyTextFieldPlaceholder = "\(selectedCurrency?.enName ?? "Cuerency")"
    }
    
    // MARK: - JSON
    func fetchCurrencies() async throws {
        DispatchQueue.main.async { self.isLoading = true }
            
        do {
            let data = try await NetworkManager.shared.fetchCurrencies()
                    
            DispatchQueue.main.async {
                self.allCurrencies = data
                self.dataDownloaded = true
                self.isLoading = false
            }
            
        } catch {
            print("🚨 Detail ERROR baby:\n \(error)")
                
            DispatchQueue.main.async {
                self.isLoading = false
                self.dataDownloaded = false
            }
                
            throw error
        }
    }
}

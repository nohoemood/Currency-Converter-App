// ListViewModel.swift by mac 13.09.2026

import Combine
import Foundation

class ListViewModel: ObservableObject {
    @Published var currencies: [Currency] = []
    @Published var dataDownloaded: Bool = false

    var filtredCurrencies: [Currency] {
        let searchText = searchTextFieldContent.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !searchText.isEmpty else {
            return currencies
        }

        return currencies.filter { currency in
            let matchName = currency.enName.localizedCaseInsensitiveContains(searchText)
            let matchCode = currency.charCode.localizedCaseInsensitiveContains(searchText)
            let matchCountry = currency.countryName.localizedCaseInsensitiveContains(searchText)

            return matchName || matchCode || matchCountry
        }
    }

    // TextField's properties
    let searchTextFieldPlaceholder: String = "Search currency"
    var searchTextFieldContent: String = ""

    // MARK: - Init
    init(currencies: [Currency]?) {
        guard let unWrappedCurrencies = currencies else { return }
        self.currencies = unWrappedCurrencies
    }
    
    func loadCurrenciesForList() async {
        do {
            let data = try await NetworkManager.shared.fetchCurrencies()
            self.currencies = data
            DispatchQueue.main.async {
                self.dataDownloaded = true
            }
        } catch {
            DispatchQueue.main.async {
                self.dataDownloaded = false
            }
            print(error)
        }
    }
}

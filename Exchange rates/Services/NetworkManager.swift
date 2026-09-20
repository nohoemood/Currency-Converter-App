// NetworkManager.swift by mac 18.09.2026

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private var cachedCurrencies: [Currency]?
    
    private init() {}
    
    // JSON
    func fetchCurrencies() async throws -> [Currency] {
        if let cached = cachedCurrencies { return cached }
        
        let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(CurrencyResponse.self, from: data)
        let currencies = Array(response.valute.values).sorted { $0.enName < $1.enName }
        
        self.cachedCurrencies = currencies
        return currencies
    }
    
    // XML
//    func fetchAnalytics(for charCode: String) async throws -> CurrencyAnalytics {}
    
}

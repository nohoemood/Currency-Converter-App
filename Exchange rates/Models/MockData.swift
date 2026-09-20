// MockData.swift by mac 09.09.2026 

import Foundation

struct MockData {
    static func getPopularCurrencies() -> [Currency] {
        let popularCurrencies = [
            Currency(id: "0001", charCode: "USD", nominal: 1, name: "USA Dollar", value: 86.5857, previousValue: 84.951),
            Currency(id: "0002", charCode: "EUR", nominal: 1, name: "Euro", value: 100.5693, previousValue: 101.9123),
            Currency(id: "0003", charCode: "GBP", nominal: 1, name: "Pound Sterling", value: 117.0465, previousValue: 116.9912)
        ]
        
        return popularCurrencies
    }
    
}

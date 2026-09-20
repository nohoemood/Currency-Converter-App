// CurrencyResponse.swift by mac 12.09.2026 

import Foundation

struct CurrencyResponse: Decodable {
    let valute: [String: Currency]
    
    enum CodingKeys: String, CodingKey {
        case valute = "Valute"
    }
}

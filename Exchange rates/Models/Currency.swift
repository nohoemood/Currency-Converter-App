// Currency.swift by mac 09.09.2026

import Foundation
import SwiftUI

struct Currency: Identifiable, Hashable, Decodable {
    let id: String

    let charCode: String
    let name: String

    let nominal: Int

    let value: Double
    let previousValue: Double

    /// Data from JSON
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case charCode = "CharCode"
        case name = "Name"
        case nominal = "Nominal"
        case value = "Value"
        case previousValue = "Previous"
    }

    // MARK: - Computed properties
    // FIXME: - Fix flag/symbol coumpeted properties
    var flag: Image {
        let imageName = "Flags/\(charCode)"
        if let _ = UIImage(named: imageName) {
            return Image(imageName)
        } else {
            return Image(systemName: "square.on.square")
        }
    }

    var symbol: Image {
        let imageName = "Symbols/\(charCode)"
        if let _ = UIImage(named: imageName) {
            return Image(imageName)
        } else {
            return Image(systemName: "dollarsign.circle")
        }
    }

    var flagName: String {
        return "Flags/\(charCode)"
    }

    var symbolName: String {
        return "Symbols/\(charCode)"
    }

    var countryName: String {
        switch charCode {
        case "AUD": return "Australia"
        case "AZN": return "Azerbaijan"
        case "GBP": return "UK"
        case "AMD": return "Armenia"
        case "BYN": return "Belarus"
        case "BGN": return "Bulgaria"
        case "BRL": return "Brazil"
        case "HUF": return "Hungary"
        case "VND": return "Vietnam"
        case "HKD": return "Hong Kong"
        case "GEL": return "Georgia"
        case "DKK": return "Denmark"
        case "AED": return "UAE"
        case "USD": return "USA"
        case "EUR": return "EU"
        case "EGP": return "Egypt"
        case "INR": return "India"
        case "IDR": return "Indonesia"
        case "KZT": return "Kazakhstan"
        case "CAD": return "Canada"
        case "QAR": return "Qatar"
        case "KGS": return "Kyrgyzstan"
        case "CNY": return "China"
        case "MDL": return "Moldova"
        case "NZD": return "New Zealand"
        case "NOK": return "Norway"
        case "PLN": return "Poland"
        case "RON": return "Romania"
        case "XDR": return "IMF"
        case "SGD": return "Singapore"
        case "TJS": return "Tajikistan"
        case "THB": return "Thailand"
        case "TRY": return "Turkey"
        case "TMT": return "Turkmenistan"
        case "UZS": return "Uzbekistan"
        case "UAH": return "Ukraine"
        case "CZK": return "Czech Republic"
        case "SEK": return "Sweden"
        case "CHF": return "Switzerland"
        case "RSD": return "Serbia"
        case "ZAR": return "South Africa"
        case "KRW": return "South Korea"
        case "JPY": return "Japan"
        case "DZD": return "Algeria"
        case "ETB": return "Ethiopia"
        case "BHD": return "Bahrain"
        case "OMR": return "Oman"
        case "BDT": return "Bangladesh"
        case "MMK": return "Myanmar"
        case "MNT": return "Mongolia"
        case "NGN": return "Nigeria"
        case "CUP": return "Cuba"
        case "SAR": return "Saudi Arabia"
        case "BOB": return "Bolivia"
        case "IRR": return "Iran"
        default: return "Unknown Country"
        }
    }

    var enName: String {
        switch charCode {
        case "AUD": return "Australian Dollar"
        case "AZN": return "Azerbaijani Manat"
        case "GBP": return "British Pound"
        case "AMD": return "Armenian Dram"
        case "BYN": return "Belarusian Ruble"
        case "BGN": return "Bulgarian Lev"
        case "BRL": return "Brazilian Real"
        case "HUF": return "Hungarian Forint"
        case "VND": return "Vietnamese Dong"
        case "HKD": return "Hong Kong Dollar"
        case "GEL": return "Georgian Lari"
        case "DKK": return "Danish Krone"
        case "AED": return "UAE Dirham"
        case "USD": return "USA Dollar"
        case "EUR": return "Euro"
        case "EGP": return "Egyptian Pound"
        case "INR": return "Indian Rupee"
        case "IDR": return "Indonesian Rupiah"
        case "KZT": return "Kazakhstani Tenge"
        case "CAD": return "Canadian Dollar"
        case "QAR": return "Qatari Riyal"
        case "KGS": return "Kyrgystani Som"
        case "CNY": return "Chinese Yuan"
        case "MDL": return "Moldovan Leu"
        case "NZD": return "New Zealand Dollar"
        case "NOK": return "Norwegian Krone"
        case "PLN": return "Polish Zloty"
        case "RON": return "Romanian Leu"
        case "XDR": return "Special Drawing Rights"
        case "SGD": return "Singapore Dollar"
        case "TJS": return "Tajikistani Somoni"
        case "THB": return "Thai Baht"
        case "TRY": return "Turkish Lira"
        case "TMT": return "Turkmenistan Manat"
        case "UZS": return "Uzbekistani Som"
        case "UAH": return "Ukrainian Hryvnia"
        case "CZK": return "Czech Koruna"
        case "SEK": return "Swedish Krona"
        case "CHF": return "Swiss Franc"
        case "RSD": return "Serbian Dinar"
        case "ZAR": return "South African Rand"
        case "KRW": return "South Korean Won"
        case "JPY": return "Japanese Yen"
        case "DZD": return "Algerian Dinar"
        case "ETB": return "Ethiopian Birr"
        case "BHD": return "Bahraini Dinar"
        case "OMR": return "Omani Rial"
        case "BDT": return "Bangladeshi Taka"
        case "MMK": return "Myanmar Kyat"
        case "MNT": return "Mongolian Togrog"
        case "NGN": return "Nigerian Naira"
        case "CUP": return "Cuban Peso"
        case "SAR": return "Saudi Riyal"
        case "BOB": return "Bolivian Boliviano"
        case "IRR": return "Iranian Rial"
        default: return "Unknown Currency"
        }
    }

    // MARK: - Init
    init(id: String, charCode: String, nominal: Int, name: String, value: Double, previousValue: Double) {
        self.id = id

        self.charCode = charCode
        self.name = name

        self.nominal = nominal

        self.value = value
        self.previousValue = previousValue
    }
}

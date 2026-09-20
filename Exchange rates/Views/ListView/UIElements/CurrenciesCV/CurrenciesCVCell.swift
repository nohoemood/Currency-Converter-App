// CurrenciesCVCell.swift by mac 15.09.2026

import Foundation
import SwiftUI
import UIKit

class CurrenciesCVCell: UICollectionViewCell {
    private let symbolImageView = CurrenciesCVCellFactory.getImageView(cornerRadius: nil)
    
    private let title = CurrenciesCVCellFactory.getLabel(font: 22, weight: .semibold, nameColor: "Text_Primary_First", textAlignment: .left)
    private let charCode = CurrenciesCVCellFactory.getLabel(font: 18, weight: .medium, nameColor: "Text_Primary_Second", textAlignment: .left)
    private let value = CurrenciesCVCellFactory.getLabel(font: 18, weight: .medium, nameColor: "Text_Primary_First", textAlignment: .left)
    
    private let countryName = CurrenciesCVCellFactory.getLabel(font: 16, weight: .medium, nameColor: "Text_Primary_First", textAlignment: .right)
    private let countryFlagImageView = CurrenciesCVCellFactory.getImageView(cornerRadius: 3)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(symbolImageView)
        contentView.addSubview(title)
        contentView.addSubview(charCode)
        contentView.addSubview(value)
        
        contentView.addSubview(countryName)
        contentView.addSubview(countryFlagImageView)
        
        NSLayoutConstraint.activate([
            // Symbol
            symbolImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            symbolImageView.widthAnchor.constraint(equalToConstant: 55),
            symbolImageView.heightAnchor.constraint(equalToConstant: 55),
            
            // Title
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9.5),
            title.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 10),
            title.widthAnchor.constraint(equalToConstant: 184),
            
            // CharCode
            charCode.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 10),
            charCode.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            
            // Value
            value.centerYAnchor.constraint(equalTo: charCode.centerYAnchor),
            value.leadingAnchor.constraint(equalTo: charCode.trailingAnchor, constant: 4),
            
            // Country name
            countryName.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            countryName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            countryName.widthAnchor.constraint(equalToConstant: 80),
            
            // Flag
            countryFlagImageView.centerYAnchor.constraint(equalTo: value.centerYAnchor),
            countryFlagImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            countryFlagImageView.widthAnchor.constraint(equalToConstant: 40),
            countryFlagImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(currency: Currency) {
        symbolImageView.image = UIImage(named: currency.symbolName)
        title.text = currency.enName
        charCode.text = currency.charCode
        value.text = String(format: "%.4f", currency.value)
        
        countryName.text = currency.countryName
        countryFlagImageView.image = UIImage(named: currency.flagName)
    }
}

// CurrenciesCVCellFactory.swift by mac 16.09.2026

import Foundation
import UIKit

enum CurrenciesCVCellFactory {
    static func getImageView(cornerRadius: CGFloat?) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        if let unWrappedCornerRadius = cornerRadius {
            imageView.layer.cornerRadius = unWrappedCornerRadius
            imageView.clipsToBounds = true
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func getLabel(font: CGFloat, weight: UIFont.Weight, nameColor: String, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: font, weight: weight)
        label.textColor = UIColor(named: nameColor)
        label.textAlignment = textAlignment
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

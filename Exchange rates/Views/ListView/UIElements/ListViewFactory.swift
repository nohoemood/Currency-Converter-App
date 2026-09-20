// ListViewFactory.swift by mac 13.09.2026 

import Foundation
import UIKit

struct ListViewFactory {
    
    static func getView(cornerRadius: CGFloat, colorName: String) -> UIView {
        let view = UIView()
        
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = UIColor(named: colorName)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func getImage(name: String, colorName: String) -> UIImageView {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: name)
        imageView.tintColor = UIColor(named: colorName)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func getTextField(placeholder: String, textColorName: String, placeholderColorName: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none

        textField.textColor = UIColor(named: textColorName)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(named: placeholderColorName) ?? .lightGray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    static func getCollectionView(layout: UICollectionViewLayout, cellRegisterName: String, backgroundColor: UIColor) -> UICollectionView {
        let currenciesCV = UICollectionView(frame: .zero, collectionViewLayout: layout)

        currenciesCV.backgroundColor = .clear
        currenciesCV.register(CurrenciesCVCell.self, forCellWithReuseIdentifier: cellRegisterName)

        currenciesCV.translatesAutoresizingMaskIntoConstraints = false
        return currenciesCV
    }
    
}

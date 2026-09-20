// CurrenciesCVDelegate.swift by mac 15.09.2026 

import Foundation
import UIKit

class CurrenciesCVDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var listViewModel: ListViewModel? = nil
    
    var didSelect: ((_ currency: Currency) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let correctCurrency = listViewModel?.filtredCurrencies[indexPath.item] else { return }
        
        didSelect!(correctCurrency)
        print("Tap on \(correctCurrency.enName)")
    }
}

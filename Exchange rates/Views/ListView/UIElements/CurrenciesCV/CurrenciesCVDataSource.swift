// CurrenciesCVDataSource.swift by mac 15.09.2026 

import Foundation
import UIKit

class CurrenciesCVDataSource: NSObject, UICollectionViewDataSource {
    var listViewModel: ListViewModel? = nil
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listViewModel?.filtredCurrencies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrenciesCVCell", for: indexPath) as! CurrenciesCVCell
        guard let correctCurrency = listViewModel?.filtredCurrencies[indexPath.item] else { return cell }

        cell.configure(currency: correctCurrency)
        return cell
    }
}

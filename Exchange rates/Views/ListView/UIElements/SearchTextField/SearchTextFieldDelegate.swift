// SearchTextFieldDelegate.swift by mac 13.09.2026

import Foundation
import UIKit

class SearchTextFieldDelegate: NSObject, UITextFieldDelegate {
    var listViewModel: ListViewModel?
    var onTextUpdate: (() -> Void)?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let actualText = textField.text ?? ""
        listViewModel?.searchTextFieldContent = actualText
        print("RETURN tapped, text: \(actualText)")
        
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
                
        guard let stringRange = Range(range, in: currentText) else { return true }
                
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        listViewModel?.searchTextFieldContent = updatedText
                
        onTextUpdate?()
        return true
    }
}

// ListView.swift by mac 13.09.2026

import Foundation
import SwiftUI

struct ListViewWrapper: UIViewRepresentable {
    let listViewModel: ListViewModel
    
    var onAction: (Currency) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onAction: onAction)
    }
    
    func makeUIView(context: Context) -> ListView {
        let customView = ListView(listVM: listViewModel)
        customView.delegate = context.coordinator
        
        return customView
    }
    
    func updateUIView(_ uiView: ListView, context: Context) {}
    
    class Coordinator: NSObject, ListViewDelegate {
        var onAction: (Currency) -> Void
        
        init(onAction: @escaping (Currency) -> Void) {
            self.onAction = onAction
        }
        
        func customViewDidTapButton(with currency: Currency) {
            onAction(currency)
        }
    }
}

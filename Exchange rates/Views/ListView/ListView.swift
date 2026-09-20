// ListView.swift by mac 13.09.2026

import Foundation
import UIKit

// magnifyingglass

protocol ListViewDelegate: AnyObject {
    func customViewDidTapButton(with curency: Currency)
}

class ListView: UIView {
    // MARK: - DATA
    private var isUISetupDone = false
    
    weak var delegate: ListViewDelegate?
    let listViewModel: ListViewModel
    
    /// Search TextField
    private let searchTextFieldDelegate = SearchTextFieldDelegate()

    // Currencies Compositial Layout
    private let currenciesCVDelegate = CurrenciesCVDelegate()
    private let currenciesCVDataSource = CurrenciesCVDataSource()
    
    // MARK: - UI
    // Search
    private let searchTextFieldView = ListViewFactory.getView(cornerRadius: 22, colorName: "Secondary_Second")
    private let searchTextFieldImageView = ListViewFactory.getImage(name: "magnifyingglass", colorName: "Secondary_Third")
    private lazy var searchTextField = ListViewFactory.getTextField(placeholder: listViewModel.searchTextFieldPlaceholder, textColorName: "Text_Primary_First", placeholderColorName: "Text_Primary_Second")
    private let animatedBorderView = SplitAnimatedBorderView(cornerRadius: 22, borderColor: UIColor(named: "Accent"))
    
    /// List of currencies
    private var currenciesCV = ListViewFactory.getCollectionView(layout: CurrenciesCVLayout.createLayout(), cellRegisterName: "CurrenciesCVCell", backgroundColor: .clear)
    
    // MARK: - Init
    init(listVM: ListViewModel) {
        self.listViewModel = listVM
        super.init(frame: .zero)

        backgroundColor = UIColor(named: "Secondary_First")

        setupDowloadedUI()
        setupTextFieldAction()
        setupCurrenciesCollectionView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecircle
    override func didMoveToWindow() {
        super.didMoveToWindow()
            
        if window != nil {
            Task {
                await listViewModel.loadCurrenciesForList()
                self.currenciesCV.reloadData()
            }
        }
    }
    
    // MARK: - Funcs
    private func setupCurrenciesCollectionView() {
        currenciesCVDelegate.listViewModel = listViewModel
        currenciesCVDataSource.listViewModel = listViewModel
        currenciesCV.delegate = currenciesCVDelegate
        currenciesCV.dataSource = currenciesCVDataSource
        
        currenciesCVDelegate.didSelect = { [weak self] currency in
            self?.delegate?.customViewDidTapButton(with: currency)
        }
    }
    
    private func setupTextFieldAction() {
        // Hide keyboard through tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
        
        // Keyboard delegate
        searchTextFieldDelegate.listViewModel = listViewModel
        
        searchTextFieldDelegate.onTextUpdate = { [weak self] in
            self?.currenciesCV.reloadData()
        }
        
        searchTextField.delegate = searchTextFieldDelegate

        // Animations
        searchTextField.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.6, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
                self.searchTextFieldImageView.tintColor = UIColor(named: "Accent")
            },
            completion: nil)
        }, for: .editingDidBegin)
        searchTextField.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.6, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
                self.searchTextFieldImageView.tintColor = UIColor(named: "Text_Primary_First")
            },
            completion: nil)
        }, for: .editingDidEnd)
    }

    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    // MARK: - Setup UI
    private func setupErrorUI() {}
    
    private func setupDowloadedUI() {
        animatedBorderView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(searchTextFieldView)
        searchTextFieldView.addSubview(searchTextFieldImageView)
        searchTextFieldView.addSubview(searchTextField)
        searchTextFieldView.addSubview(animatedBorderView)
        
        addSubview(currenciesCV)
        
        NSLayoutConstraint.activate([
            // TextField layout
            // View
            searchTextFieldView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            searchTextFieldView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchTextFieldView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            searchTextFieldView.widthAnchor.constraint(equalToConstant: 338),
            searchTextFieldView.heightAnchor.constraint(equalToConstant: 50),
            
            // Image
            searchTextFieldImageView.centerYAnchor.constraint(equalTo: searchTextFieldView.centerYAnchor),
            searchTextFieldImageView.leadingAnchor.constraint(equalTo: searchTextFieldView.leadingAnchor, constant: 11),
            
            searchTextFieldImageView.widthAnchor.constraint(equalToConstant: 22),
            searchTextFieldImageView.heightAnchor.constraint(equalToConstant: 22),
            
            // TextField
            searchTextField.centerYAnchor.constraint(equalTo: searchTextFieldView.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchTextFieldImageView.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: searchTextFieldView.trailingAnchor, constant: -11),
            
            // Animation border
            animatedBorderView.topAnchor.constraint(equalTo: searchTextFieldView.topAnchor),
            animatedBorderView.bottomAnchor.constraint(equalTo: searchTextFieldView.bottomAnchor),
            animatedBorderView.leadingAnchor.constraint(equalTo: searchTextFieldView.leadingAnchor),
            animatedBorderView.trailingAnchor.constraint(equalTo: searchTextFieldView.trailingAnchor),
            
            // Currencies collection view layout
            currenciesCV.topAnchor.constraint(equalTo: searchTextFieldView.bottomAnchor, constant: 16),
            currenciesCV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            currenciesCV.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            currenciesCV.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        searchTextField.addTarget(self, action: #selector(textFieldDidFocus), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(textFieldDidUnfocus), for: .editingDidEnd)
    }
    
    // MARK: - Additional elements
    @objc private func textFieldDidFocus() {
        animatedBorderView.animate(isFocused: true)
    }

    @objc private func textFieldDidUnfocus() {
        animatedBorderView.animate(isFocused: false)
    }
}

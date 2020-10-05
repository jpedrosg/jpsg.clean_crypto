//
//  CryptoPresenter.swift
//  CleanStore
//
//  Created by João Pedro Giarrante on 27/09/20.
//  Copyright (c) 2020 Clean Swift LLC. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CryptoPresentationLogic {
    func presentFetchedCrypto(response: CryptoModels.FetchCrypto.Response)
    func presentCryptoError(error: Error)
    func presentScreenLoading()
    func hideScreenLoading()
    func enableDetailButton()
    func disableDetailButton()
}

enum DefaultModelValues: String {
    case price = " Não Encontrado "
    case ticket = " ? "
}

class CryptoPresenter: CryptoPresentationLogic {
    
    weak var viewController: CryptoDisplayLogic?
    
    
    // MARK: Present FetchCrypto
    
    func presentFetchedCrypto(response: CryptoModels.FetchCrypto.Response) {
        var displayedCrypto: CryptoModels.FetchCrypto.ViewModel.DisplayedCrypto
        
        var formattedPrice = DefaultModelValues.price.rawValue
        
        // Using Extension
        if let code = response.assetIdQuote, let value = response.rate {
            formattedPrice = String.formatValueForCurrencyCode(value: value, myCode: code) ?? DefaultModelValues.price.rawValue
        }
        
        // Creating ViewModel
        displayedCrypto = CryptoModels.FetchCrypto.ViewModel.DisplayedCrypto(price: formattedPrice, ticket: response.assetIdBase ?? DefaultModelValues.ticket.rawValue)
        
        // Displaying
        let viewModel = CryptoModels.FetchCrypto.ViewModel(displayedCrypto: displayedCrypto)
        viewController?.displayFetchedCrypto(viewModel: viewModel)
    }
    
    func presentCryptoError(error: Error) {
        let displayedCrypto = CryptoModels.FetchCrypto.ViewModel.DisplayedCrypto(price: DefaultModelValues.price.rawValue, ticket: DefaultModelValues.ticket.rawValue)
        viewController?.displayCryptoError(error: error.localizedDescription, viewModel: CryptoModels.FetchCrypto.ViewModel(displayedCrypto: displayedCrypto))
    }
    
    func presentScreenLoading() {
        viewController?.displayScreenLoading()
    }
    
    func hideScreenLoading() {
        viewController?.hideScreenLoading()
    }
    
    func enableDetailButton() {
        viewController?.enableDetailButton()
    }
    
    func disableDetailButton() {
        viewController?.disableDetailButton()
    }
}

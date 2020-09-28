//
//  BitcoinViewController.swift
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

protocol BitcoinDisplayLogic: class
{
    func displayFetchedCrypto(viewModel: Bitcoin.FetchCrypto.ViewModel)
}

class BitcoinViewController: UIViewController, BitcoinDisplayLogic
{
    var interactor: BitcoinBusinessLogic?
    var router: (NSObjectProtocol & BitcoinRoutingLogic & BitcoinDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = BitcoinInteractor()
        let presenter = BitcoinPresenter()
        let router = BitcoinRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchCrypto()
    }
    
    // MARK: Fetch Crypto
    
    @IBOutlet weak var lblTicket: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var txtTicket: UITextField!
    @IBOutlet weak var txtCurrency: UITextField!
    
    @IBAction func clickCryptoImage(_ sender: UIButton) {
        fetchCrypto()
    }
    
    func fetchCrypto()
    {

        var ticketText:String?
        if txtTicket.text != "" {
            ticketText = txtTicket.text
        }
        
        var ticketPlaceholder:String?
        if txtTicket.placeholder != "" {
            ticketPlaceholder = txtTicket.placeholder
        }
        
        var currencyText:String?
        if txtCurrency.text != "" {
            currencyText = txtCurrency.text
        }
        
        var currencyPlaceholder:String?
        if txtCurrency.placeholder != "" {
            currencyPlaceholder = txtCurrency.placeholder
        }
        
        let request = Bitcoin.FetchCrypto.Request(ticket: ticketText ?? ticketPlaceholder ?? "LTC", currency: currencyText ?? currencyPlaceholder ?? "BRL")
        interactor?.fetchCrypto(request: request)
        indicator.startAnimating()
    }
    
    func displayFetchedCrypto(viewModel: Bitcoin.FetchCrypto.ViewModel)
    {
        lblTicket.text = viewModel.displayedCrypto.ticket
        lblPrice.text = viewModel.displayedCrypto.price
        indicator.stopAnimating()
        
    }
}

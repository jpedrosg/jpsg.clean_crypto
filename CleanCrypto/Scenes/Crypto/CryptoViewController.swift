//
//  CryptoViewController.swift
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

protocol CryptoDisplayLogic: class {
    func displayFetchedCrypto(viewModel: CryptoModels.FetchCrypto.ViewModel)
}

class CryptoViewController: UIViewController, CryptoDisplayLogic {
    var interactor: CryptoBusinessLogic?
    var router: (NSObjectProtocol & CryptoRoutingLogic & CryptoDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = CryptoInteractor()
        let presenter = CryptoPresenter()
        let router = CryptoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchCrypto()
    }
    
    // MARK: Functions
    
    fileprivate func setupView(){
        btnReload.layer.cornerRadius = 5
    }
    
    // MARK: Outlets and Actions
    
    @IBOutlet weak var lblTicket: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var txtTicket: UITextField!
    @IBOutlet weak var txtCurrency: UITextField!
    @IBOutlet weak var btnReload: UIButton!
    
    @IBAction func clickCryptoImage(_ sender: UIButton) {
        fetchCrypto()
    }
    
    // MARK: Fetch Crypto
    
    func fetchCrypto() {

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
        
        let request = CryptoModels.FetchCrypto.Request(ticket: ticketText ?? ticketPlaceholder ?? "LTC", currency: currencyText ?? currencyPlaceholder ?? "BRL")
        interactor?.fetchCrypto(request: request)
        indicator.startAnimating()
    }
    
    func displayFetchedCrypto(viewModel: CryptoModels.FetchCrypto.ViewModel) {
        lblTicket.text = viewModel.displayedCrypto.ticket
        lblPrice.text = viewModel.displayedCrypto.price
        indicator.stopAnimating()
        txtCurrency.text = ""
        txtTicket.text = ""
    }
}

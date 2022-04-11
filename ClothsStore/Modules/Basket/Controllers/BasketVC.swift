//
//  BasketVC.swift
//  ClothsStore
//
//  Created by Zoombie on 04/04/22.
//

import Foundation
import UIKit

class BasketVC: UIViewController, BasketBase {
   
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    @IBOutlet private weak var total: UILabel!
    @IBOutlet var noProductsLabel: UILabel!

    // MARK: - Variables
    var coordinator: BasketBaseCoordinator?
    var viewModel: BasketViewModel?

    // MARK: - Initializers
    init(coordinator: BasketBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Catalogue"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Controller Life Cycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpBindings()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel?.cdHelper.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel?.cdHelper.delegate = nil
    }
    
    //MARK: Methods
    private func setUpBindings() {
        viewModel?.fetchData()
        
        DispatchQueue.main.async {
            self.displayPlaceHolderText()
            self.tableView.reloadData()
        }
    }
    
    private func displayPlaceHolderText() {
        DispatchQueue.main.async {
            if let isEmpty = self.viewModel?.cart.isEmpty {
                self.noProductsLabel.isHidden = !isEmpty
            }
        }
    }
}

//MARK: UITableViewDataSource

extension BasketVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.cart.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: BasketCell.self, for: indexPath)
        cell.cart = viewModel!.cart[indexPath.row]
        
        //Quantity Stepper
        
        cell.stepperUpdatedCallback = { [unowned self] qnty, btn in
            
            if let item = viewModel!.cart[indexPath.row].item {
                if !checkAvailabilityForCart(forItem: item, quantity: qnty) {
                    cell.quantity = cell.quantity - 1
                }
            }
        }
       
        cell.selectionStyle = .none
        return cell
    }
}

extension BasketVC: Refreshable {
    func updateRows(forindexPath indexPath: IndexPath) {
        displayPlaceHolderText()
        viewModel?.fetchData()
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.updateUI()
    }
    func deleteRows(forindexPath indexPath: IndexPath) {
        displayPlaceHolderText()
        viewModel?.fetchData()
        self.tableView.reloadData()
        self.updateUI()
    }
    
    func updateUI() {
        if viewModel!.cart.isEmpty {
            total.isHidden = true
        }else{
            total.text = "Total: \(Cart.cartItemsTotal().currencyString())"
            total.isHidden = false
        }
    }
}

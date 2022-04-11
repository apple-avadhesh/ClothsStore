//
//  WishListVC.swift
//  ClothsStore
//
//  Created by Zoombie on 07/04/22.
//

import Foundation
import UIKit

class WishListVC: UIViewController, WishListBase {
   
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    @IBOutlet var noWishListLabel: UILabel!

    // MARK: - Variables
    var coordinator: WishListBaseCoordinator?
    var cdHelper = CoreDataItemHelper()
    var viewModel: WishListViewModel?
    
    @Published var shouldRefreshCartBadge : Bool = false

    // MARK: - Initializers
    init(coordinator: WishListBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Controller Life Cycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpBindings()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        title = "Wishlist"
        
        cdHelper.type = .wishlist
    }

    private func setUpBindings() {
        viewModel?.fetchData()
        displayPlaceHolderText()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func displayPlaceHolderText() {
        DispatchQueue.main.async {
            if let isEmpty = self.viewModel?.items.isEmpty {
                self.noWishListLabel.isHidden = !isEmpty
            }
        }
    }
}

extension WishListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: WishListCell.self, for: indexPath)
        cell.item = viewModel!.items[indexPath.row]
        
        cell.addToCartCallback = { [unowned self] in
            
            if self.checkAvailability(forItem: viewModel!.items[indexPath.row]) {
                shouldRefreshCartBadge = true
                viewModel!.items[indexPath.row].updateWishlist()
            }
            
            setUpBindings()
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

extension WishListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = UIContextualAction(style: .destructive, title: "Remove") {  (contextualAction, view, boolValue) in
            self.viewModel!.items[indexPath.row].updateWishlist()
            self.viewModel!.fetchData()
            self.displayPlaceHolderText()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [item])
        return swipeActions
    }
}

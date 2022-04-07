//
//  WishListVC.swift
//  ClothsStore
//
//  Created by Avadhesh on 07/04/22.
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
    
    // MARK: - Variables
    var coordinator: WishListBaseCoordinator?
    var cdHelper = CoreDataHelper()
    var viewModel: WishListViewModel?

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
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension WishListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: WishListCell.self, for: indexPath)
        cell.configure(with: viewModel!.items[indexPath.row])
        return cell
    }
}

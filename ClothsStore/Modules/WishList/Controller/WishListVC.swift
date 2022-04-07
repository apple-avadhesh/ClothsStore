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
        setUpBindings()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        title = "Wishlist"
        
        cdHelper.type = .wishlist
    }

    private func setUpBindings() {
        viewModel?.fetchData()
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

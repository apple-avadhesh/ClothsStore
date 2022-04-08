//
//  CatalogueViewController.swift
//  ClothsStore
//
//  Created by Zoombie on 04/04/22.
//

import Foundation
import UIKit
import SwiftUI

class CatalogueVC: UIViewController, CatalogueBase {
    
    // MARK: - Variables
    var coordinator: CatalogueBaseCoordinator?
    var viewModel: CatalogueViewModel?
    private var products = [Product]()

    // MARK: - Initializers
    init(coordinator: CatalogueBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpBindingsAndAddView()
        self.setupUI()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        title = "Catalogue"
    }
    
    private func setUpBindingsAndAddView() {
        guard let viewModel = viewModel else { return }
        
        viewModel.fetchData()
        
        var catalogueView = CatalogueGridView(viewModel: viewModel)
        catalogueView.selectedProduct = { [self] product in
            print(product)
            coordinator?.moveTo(flow: .catalogue(.productDetail), userData: ["product": product])
        }

        let controller = UIHostingController(rootView: catalogueView)
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        controller.didMove(toParent: self)

        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//
//  CatalogueViewController.swift
//  ClothsStore
//
//  Created by Avadhesh on 04/04/22.
//

import Foundation
import UIKit
import SwiftUI

class CatalogueVC: UIViewController, CatalogueBase {
   
    // MARK: Outlets
    
    // MARK: - Variables
    var coordinator: CatalogueBaseCoordinator?
    
    // MARK: - Initializers
    init(coordinator: CatalogueBaseCoordinator) {
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
    
    // MARK: - Embed SwiftUI View
    
    @IBSegueAction func addCatalogueView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: CatalogueView())
    }
}

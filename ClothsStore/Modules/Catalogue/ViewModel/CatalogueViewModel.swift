//
//  CatalogueViewModel.swift
//  ClothsStore
//
//  Created by Avadhesh on 05/04/22.
//

import Foundation
import CoreData

class CatalogueViewModel: ObservableObject {
    
    //MARK: Properties
    
    @Published var items = [Item]()
    var cdHelper = CoreDataHelper()

    // MARK: Methods
        
    func fetchData() {
        let reqModel = RequestModel.init(method: .GET, path: "0f78766a6d68832d309d")
        
        APIClient().send(reqModel) { (result: Result<ProductModel, APIError>) -> Void in
            
            switch result {
            case .success(let dataModel):
                if let products = dataModel.products {
                    DispatchQueue.main.async {
                        
                        if UserDefaults.standard.getFirstLoad() == false {
                            Item.loadProducts(products: products, withContainer: CoreDataManager.shared.persistentContainer)
                            UserDefaults.standard.setFirsLoad()
                        }
                        
                        self.cdHelper.type = .all
                        self.items = self.cdHelper.fetchedResultsController.fetchedObjects!
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

//
//  CatalogueViewModel.swift
//  ClothsStore
//
//  Created by Zoombie on 05/04/22.
//

import Foundation
import CoreData

class CatalogueViewModel: ObservableObject {
    
    //MARK: Properties
    
    @Published var items = [Item]()
    var cdHelper = CoreDataItemHelper()
    
    // MARK: Methods
    
    func fetchData() {
        let reqModel = RequestModel.init(method: .GET, path: "0f78766a6d68832d309d")
        
        APIClient().send(reqModel) { (result: Result<ProductModel, APIError>) -> Void in
            
            switch result {
            case .success(let dataModel):
                if let products = dataModel.products {
                    
                    if UserDefaults.standard.getFirstLoad() == false {
                        Item.loadProducts(products: products, withContainer: CoreDataManager.shared.persistentContainer)
                        UserDefaults.standard.setFirsLoad()
                    }
                    
                    self.getDataFromDB()
                }
            case .failure(let failure):
                print(failure)
                self.getDataFromDB()
            }
        }
    }
    
    func getDataFromDB() {
        self.cdHelper.type = .all
        DispatchQueue.main.async {
            self.items = self.cdHelper.fetchedResultsController.fetchedObjects!
        }
    }
}

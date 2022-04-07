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
    
    var _fetchedResultsController: NSFetchedResultsController<Item>? = nil
    var managedObjectContext :NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext

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
                        
                        self.items = self.fetchedResultsController.fetchedObjects!
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

//MARK: Manage Datasource

extension CatalogueViewModel {
    
    var fetchedResultsController: NSFetchedResultsController<Item> {
        
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
}

//
//  ProductDetailVC.swift
//  ClothsStore
//
//  Created by Avadhesh on 07/04/22.
//

import Foundation
import UIKit

class ProductDetailContainerVC: UIViewController{


    //Views
    var backButton : UIBarButtonItem!
    @IBOutlet var wishListButton: UIButton!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var addedToWishlistLabel: UILabel!
    @IBOutlet var addedToBasketLabel: UILabel!

    //Variables
    var item : Item!
    var coordinator: CatalogueBaseCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI(){
        
        navigationController?.setNavigationBarHidden(false, animated: false)

        wishListButton.dropShadow(radius: 8, opacity: 0.2, color: .black)
        addToCartButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailContainer"{
            let dest = segue.destination as! ProductDetailVC
            dest.item = item
        }
    }


    // MARK: - Actions
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addToCartAction(_ sender: Any) {
        Haptic.feedBack()

    }

    @IBAction func addToWishListAction(_ sender: Any) {
        Haptic.feedBack()
        item.updateWishlist()
    }
}

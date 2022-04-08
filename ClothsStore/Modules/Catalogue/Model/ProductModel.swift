//
//  ProductModel.swift
//  ClothsStore
//
//  Created by Zoombie on 05/04/22.
//

import Foundation

// MARK: - ProductModel
struct ProductModel: Codable {
    let products: [Product]?
}

// MARK: - Product
struct Product: Codable, Hashable {
    let name: String?
    let image: String?
    let price: Double?
    let stock: Int?
    let category: Category?
    let oldPrice: Double?
    let productID: String?

    enum CodingKeys: String, CodingKey {
        case name, image, price, stock, category, oldPrice
        case productID = "productId"
    }
}

enum Category: String, Codable {
    case pants = "Pants"
    case shoes = "Shoes"
    case tops = "Tops"
}

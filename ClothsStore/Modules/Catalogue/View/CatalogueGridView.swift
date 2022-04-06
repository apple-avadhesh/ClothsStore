//
//  CatalogueGridView.swift
//  ClothsStore
//
//  Created by Avadhesh on 06/04/22.
//

import SwiftUI

struct CatalogueGridView: View {
    
    @ObservedObject var viewModel: CatalogueViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],spacing: 20) {
                ForEach(viewModel.products, id: \.self) { product in
                    ProductCell(product: product)
                }
            }.padding(15)
        })
        .ignoresSafeArea(.all, edges: .all)
    }
}

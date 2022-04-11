//
//  CatalogueGridView.swift
//  ClothsStore
//
//  Created by Zoombie on 06/04/22.
//

import SwiftUI

struct CatalogueGridView: View {
    
    @ObservedObject var viewModel: CatalogueViewModel
    var selectedProduct : ((Item) -> Void)?

    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],spacing: 10) {
                ForEach(viewModel.items, id: \.self) { item in
                    ProductCell(item: item)
                        .background(Color(.white)).cornerRadius(10).clipShape(Rectangle()).shadow(radius: 4)
                        .onTapGesture {
                            selectedProduct?(item)
                        }
                }
            }.padding(15)
        })
        .ignoresSafeArea(.all, edges: .all)
    }
}

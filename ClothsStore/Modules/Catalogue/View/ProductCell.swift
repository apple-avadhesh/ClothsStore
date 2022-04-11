//
//  ProductCell.swift
//  ClothsStore
//
//  Created by Zoombie on 06/04/22.
//

import SwiftUI

struct ProductCell: View {
    
    //MARK: Properties
    
    var item: Item
    
    //MARK: Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            //Note: Apple's AsyncImage Not stable and flickers when scrolling
            
            AsyncImage(
                url: URL(string: item.image!)!,
                placeholder: { Text("Loading ...") },
                image: { Image(uiImage: $0).resizable() }
            )
            .frame(width: UIScreen.main.bounds.width / 2 - 25,
                   height: UIScreen.main.bounds.width / 2, alignment: .center)
            
            // Product Name
            Text(item.name ?? "")
                .font(.body)
                .foregroundColor(.gray)
                .padding(8)
            
            // Product Price
            Text(item.price.currencyString())
                .font(.title2)
                .fontWeight(.black)
                .padding(8)
        }
    }
}

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
        VStack(alignment: .leading, spacing: 5) {

            //Note: Apple's AsyncImage Not stable and flickers when scrolling
            
            AsyncImage(
                url: URL(string: item.image!)!,
                placeholder: { Text("Loading ...") },
                image: { Image(uiImage: $0).resizable() }
            )
            .frame(minWidth:UIScreen.main.bounds.width / 2 - 35, idealHeight: UIScreen.main.bounds.width / 2 )
            .background(Color.blue)
            .cornerRadius(12)
            .padding(8)
            
            Spacer()
            
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
        .background(Color.teal)
        .cornerRadius(12)
    }
}

//
//  ProductCell.swift
//  ClothsStore
//
//  Created by Avadhesh on 06/04/22.
//

import SwiftUI

struct ProductCell: View {
    
    //MARK: Properties
    
    let product: Int
    
    //MARK: Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            ZStack {
                Image(systemName: "star")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
            }
            .background(Color.blue)
            .cornerRadius(12)
            .padding(8)
          
            Spacer()
            
            // Product Name
            Text("Product Name")
                .font(.body)
                .foregroundColor(.gray)
                .padding(8)
            
            // Product Price
            Text("$ 100.0")
                .font(.title2)
                .fontWeight(.black)
                .padding(8)
        }
        .background(Color.teal)
        .cornerRadius(12)
    }
}

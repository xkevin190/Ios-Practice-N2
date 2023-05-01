//
//  Item.swift
//  TestMaking
//
//  Created by Kevin Velasco on 26/4/23.
//

import SwiftUI

struct Item: View {
    
    var image: UIImage
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
        }
        .frame(width: UIScreen.main.bounds.width / 3.6, height: UIScreen.main.bounds.height * 0.2)
        .background(.cyan)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.6), radius: 5, x: 4, y: 3)
    }
}

struct Item_Previews: PreviewProvider {
    static var previews: some View {
        Item(image: UIImage())
    }
}

//
//  ItemViewModel.swift
//  TestMaking
//
//  Created by Kevin Velasco on 28/4/23.
//

import Foundation
import CoreLocation
import SwiftUI

class ItemsViewModel: ObservableObject {
    @Published var Items: [Card] = []
    @AppStorage("items") var storage: String?
    
    
    init() {
        if storage != nil {
            
            do {
                let jsonDecoder = JSONDecoder()
                let data = storage!.data(using: .utf8)

                let itemsDecoded = try jsonDecoder.decode([Card].self, from: data!)
                
                self.Items = itemsDecoded
                 
            }
            
            catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    func addNewItem (imageData: Data, location: UserLocation) {
        Items.append(Card(localtion: location, Image: imageData))
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(Items)
            if let jsonString = String(data: data, encoding: .utf8) {
                self.storage = jsonString
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

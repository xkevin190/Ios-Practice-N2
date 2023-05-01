//
//  CardModel.swift
//  TestMaking
//
//  Created by Kevin Velasco on 28/4/23.
//

import Foundation
import SwiftUI


struct Card: Identifiable, Codable {

    var id = UUID();
    var localtion: UserLocation
    var Image: Data
}

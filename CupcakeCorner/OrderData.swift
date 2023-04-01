//
//  OrderData.swift
//  CupcakeCorner
//
//  Created by Maximilian Berndt on 2023/04/01.
//

import SwiftUI

struct OrderData: Codable {
    
    static var test: OrderData {
        return OrderData()
    }
    // TODO: future improvement
//    enum Types {
//        case Vanilla
//        case Strawberry
//        case Chocolate
//        case Rainbow
//    }
//
//    @Published var type = Types.Vanilla
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}


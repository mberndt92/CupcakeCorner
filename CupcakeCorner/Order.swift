//
//  Order.swift
//  CupcakeCorner
//
//  Created by Maximilian Berndt on 2023/04/01.
//

import SwiftUI

class Order: ObservableObject {
    
    static var test: Order {
        return Order()
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
    @Published var type = 0
    
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        return (name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty) == false
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1 / cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50 / cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}


//
//  Order.swift
//  CupcakeCorner
//
//  Created by Maximilian Berndt on 2023/04/01.
//

import SwiftUI

class Order: ObservableObject, Codable {
    
    static var test: Order {
        return Order()
    }
    
    @Published var orderData = OrderData()
    
    enum CodingKeys: CodingKey {
        case orderData
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(orderData, forKey: .orderData)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        orderData = try container.decode(OrderData.self, forKey: .orderData)
    }
    
    init() { }
    
    var hasValidAddress: Bool {
        let hasEmptyField = orderData.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        orderData.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        orderData.city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        orderData.zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        return hasEmptyField == false
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(orderData.quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(orderData.type) / 2)
        
        // $1 / cake for extra frosting
        if orderData.extraFrosting {
            cost += Double(orderData.quantity)
        }
        
        // $0.50 / cake for sprinkles
        if orderData.addSprinkles {
            cost += Double(orderData.quantity) / 2
        }
        
        return cost
    }
}


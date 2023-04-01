//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Maximilian Berndt on 2023/04/01.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderData.type) {
                        ForEach(OrderData.types.indices, id: \.self) {
                            Text(OrderData.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.orderData.quantity)", value: $order.orderData.quantity, in: 1...20)
                }
                
                // Note: weirdly enough re-enabling any special request after resetting the values for frosting / sprinkles causes a weird toggle off animation for those fields instead of simply being off
                Section {
                    Toggle("Any special request?", isOn: $order.orderData.specialRequestEnabled.animation())
                    
                    if order.orderData.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.orderData.extraFrosting)
                    }
                    
                    if order.orderData.specialRequestEnabled {
                        Toggle("Add extra sprinkles", isOn: $order.orderData.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Maximilian Berndt on 2023/04/01.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderData.name)
                TextField("Street address", text: $order.orderData.streetAddress)
                TextField("City", text: $order.orderData.city)
                TextField("Zip", text: $order.orderData.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: Order.test)
        }
    }
}

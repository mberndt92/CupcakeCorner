//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Maximilian Berndt on 2023/04/01.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmationMessage = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(
                    url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                    scale: 3) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .accessibilityHidden(true)
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order", action: {
                    Task {
                        await placeOrder()
                    }
                })
                    .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert(confirmationTitle, isPresented: $showingConfirmationMessage) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    private func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // handle response
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationTitle = "Thank you"
            confirmationMessage = "Your order for \(decodedOrder.orderData.quantity) x \(OrderData.types[decodedOrder.orderData.type].lowercased()) cupcakes is on its way!"
            showingConfirmationMessage = true
        } catch {
            confirmationTitle = "Something went wrong... :("
            confirmationMessage = "Oh no! Some evil cupcake thief robbed us of all our cupcakes and we can't handle any requests right now :("
            showingConfirmationMessage = true
        }
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: Order.test)
        }
    }
}

//
//  NewOrderView.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 11/10/21.
//

import SwiftUI

struct NewOrderView
: View
{
	@Environment(\.managedObjectContext) var context
	@ObservedObject var order: PurchaseOrder
	
    var body: some View {
        Form {
			Text("Order ID - \(order.id)")
			.font(.title.weight(.bold))
			.padding()
			
			TextField("Delivery note:", text: $order.noteForDelivery)
		}
    }
}

//struct NewOrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewOrderView()
//    }
//}

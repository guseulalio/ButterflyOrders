//
//  OrderDetailsView.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 11/10/21.
//

import SwiftUI

struct OrderDetailsView
: View
{
	@ObservedObject var order: PurchaseOrder
	
    var body: some View {
        List {
			Text("Order ID - \(order.id)")
				.font(.title.weight(.heavy))
			
			Section(header: Text("Items")) {
				ForEach(order.itemList)
				{ item in
					HStack {
						Text("Item \(item.id)")
						Spacer()
						Text("\(item.quantity) items")
					}
				}
			}
			
			Section(header: Text("Invoices")) {
				ForEach(order.invoiceList)
				{ invoice in
					HStack {
						Text("Invoice #\(invoice.invoiceNumber ?? "--")")
						Spacer()
						Text("Received status: \(invoice.receivedStatus)")
					}
				}
			}
		}
    }
}

//struct OrderDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderDetailsView()
//    }
//}

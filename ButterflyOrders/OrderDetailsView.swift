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
	
	@State private var showingNewItemView = false
	
    var body: some View {
        List {
			Text("Order ID - \(order.id)")
				.font(.title.weight(.heavy))
			
			Section(header: Text("Items")) {
				addItemButton
				
				ForEach(order.itemList)
				{ item in
					HStack {
						Text("Item \(item.id)")
						.font(.footnote)
						.foregroundColor(.secondary)
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
						.font(.footnote)
						.foregroundColor(.secondary)
						Spacer()
						Text("Received status: \(invoice.receivedStatus)")
					}
				}
			}
			
			Section(header: Text("Delivery note")) {
				Text(order.noteForDelivery)
			}
		}
    }
	
	var addItemButton: some View {
		Button {
			showingNewItemView = true
		} label: {
			NavigationLink(isActive: $showingNewItemView) {
				NewItemView(order: order)
			} label: {
				HStack {
					Spacer()
					Text("New item")
						.frame(width: 78)
						.padding(.horizontal, 12).padding(.vertical, 6)
						.background(Color.blue)
						.foregroundColor(.white)
						.clipShape(Capsule())
				}
			}
		}
	}
}

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
	@Environment(\.presentationMode) var presentationMode
	
	@State private var deliveryNote = ""
	@State private var items = [Item]()
	@State private var invoices = [Invoice]()
	
    var body: some View {
        Form {
			Text("New order")
			.font(.title.weight(.bold))
			.padding()
			
			TextField("Delivery note:", text: $deliveryNote)
			
			Section(header: Text("Items")) {
				HStack {
					Spacer()
					CapsuleButton(title: "New item", action: newItemButtonTapped, backgroundColor: .blue, width: 90)
				}
				List(items)
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
				HStack {
					Spacer()
					CapsuleButton(title: "New invoice", action: newInvoiceButtonTapped, backgroundColor: .blue, width: 110)
				}
				List(invoices)
				{ invoice in
					HStack {
						Text("Invoice #\(invoice.invoiceNumber ?? "--")")
						.font(.footnote)
						.foregroundColor(.secondary)
						
						Spacer()
						
						Text("Rcvd status: \(invoice.receivedStatus)")
					}
				}
			}
			
			HStack {
				Spacer()
				CapsuleButton(title: "Save", action: saveButtonTapped, backgroundColor: .red, width: 80)
				.padding()
			}
		}
    }
	
	func newInvoiceButtonTapped()
	{
		let now = Date()
		let invoice = Invoice(context: context)
		invoice.id = Int64.random(in: 10...(Int64.max/4))
		invoice.created = now
		invoice.lastUpdatedUserEntityId = 1
		invoice.lastUpdated = now
		invoice.activeFlag = true
		invoice.transientIdentifier = "1"
		invoice.invoiceNumber = UUID().uuidString
		invoice.receiptSentDate = nil
		invoice.receivedStatus = 1
		
		invoices.append(invoice)
	}
	
	func newItemButtonTapped()
	{
		let now = Date()
		let item = Item(context: context)
		item.id = Int64.random(in: 10...(Int64.max/4))
		item.lastUpdatedUserEntityId = 1
		item.lastUpdated = now
		item.activeFlag = true
		item.transientIdentifier = "1"
		item.productItemId = Int64.random(in: 10...Int64.max)
		item.quantity = Int16.random(in: 2...50)
		
		items.append(item)
	}
	
	func saveButtonTapped()
	{
		let now = Date()
		let order = PurchaseOrder(context: context)
		order.id = Int64.random(in: 10...(Int64.max/4))
		order.lastUpdatedUserEntityId = 1
		order.lastUpdated = now
		order.activeFlag = true
		order.approvalStatus = 1
		order.deviceKey = "xyz"
		order.issueDate = now
		order.preferredDeliveryDate = nil
		order.purchaseOrderNumber = UUID().uuidString
		order.sentDate = nil
		order.status = 1
		order.supplierId = 1
		order.deliveryNote = self.deliveryNote
		
		for item in items
		{ item.order = order }
		
		for invoice in invoices
		{ invoice.order = order }
		
		try? context.save()
		presentationMode.wrappedValue.dismiss()
	}
}

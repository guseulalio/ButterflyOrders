//
//  NewItemView.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 12/10/21.
//

import SwiftUI

struct NewItemView: View {
	@Environment(\.presentationMode) var presentationMode
	
	@ObservedObject var order: PurchaseOrder
	
	@State private var productID: Double = 1
	@State private var quantity: Int16 = 1
	
    var body: some View {
		VStack {
			Form {
				Text("New item")
				.font(.title.weight(.bold))
				.padding()
				
				Text("Product ID: \(Int(productID))")
				Slider(value: $productID, in: 1...10_000) {
					Text("Product ID: \(productID)")
				} minimumValueLabel: {
					Text("1")
				} maximumValueLabel: {
					Text("10,000")
				}
				
				Stepper("Quantity: \(quantity)", value: $quantity, in: 1...50)
			}
			
			HStack {
				Spacer()
				Button(action: saveButtonTapped) {
					Text("Save")
					.frame(width: 68)
					.padding(.horizontal, 12).padding(.vertical, 8)
					.background(Color.red)
					.foregroundColor(.white)
					.clipShape(Capsule())
					.padding()
				}
			}
		}
	}
	
	func saveButtonTapped()
	{
		if let context = order.managedObjectContext
		{
			let now = Date()
			let item = Item(context: context)
			item.id = Int64.random(in: 10...(Int64.max/4))
			item.lastUpdatedUserEntityId = 1
			item.lastUpdated = now
			item.activeFlag = true
			item.transientIdentifier = "1"
			item.productItemId = Int64(productID)
			item.quantity = quantity
			item.order = order
			
			try? context.save()
			presentationMode.wrappedValue.dismiss()
		}
	}
}

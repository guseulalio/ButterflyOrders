//
//  OrderListView.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 9/10/21.
//

import SwiftUI

struct OrderListView
: View
{
	@Environment(\.managedObjectContext) var context
	
	@FetchRequest(entity: PurchaseOrder.entity(), sortDescriptors: [])
	var orders: FetchedResults<PurchaseOrder>
	
	@State private var buttonRotation = 0.0
	@State private var addingNewOrder = false
	
	var body: some View {
		NavigationView {
			List {
				ForEach(orders)
				{ order in
					NavigationLink {
						OrderDetailsView(order: order)
					} label: {
						VStack(alignment: .leading) {
							HStack {
								Text("#\(order.id)")
								Spacer()
								Text("\(order.items?.count ?? 0) item(s)")
							}
							.font(.body)
							.foregroundColor(.primary)
							
							Text(order.lastUpdated ?? Date(), style: Text.DateStyle.date)
							.font(.footnote)
							.foregroundColor(.secondary)
						}
					}
				}
			}
			.navigationTitle("Purchase orders")
			.toolbar {
				HStack {
					fetchButton
					addButton
				}
			}
		}
	}
	
	var fetchButton: some View {
		Button {
			withAnimation { self.buttonRotation = 180 }
			
			DispatchQueue.global().async
			{
				NetworkManager.shared.managedObjectContext = context
				NetworkManager.shared.fetch
				{ result in
					switch result
					{
						case .success(_):
							print("ok")
						case .failure(let error):
							print("oh: \(error.localizedDescription)")
					}
				}
			}
			
			self.buttonRotation = 0
		} label: {
			Label("Fetch", systemImage: "arrow.triangle.2.circlepath")
			.font(.body.weight(Font.Weight.bold))
			.rotationEffect(.degrees(buttonRotation))
		}
	}
	
	var addButton: some View {
		Button {
			addingNewOrder = true
		} label: {
			NavigationLink(isActive: $addingNewOrder) {
				NewOrderView()
			} label: {
				Label("New order", systemImage: "plus.circle")
				.font(.body.weight(Font.Weight.bold))
			}
		}
	}
}

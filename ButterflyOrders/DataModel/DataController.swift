//
//  DataController.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 9/10/21.
//

import CoreData
import SwiftUI

class DataController
: ObservableObject
{
	let container: NSPersistentCloudKitContainer
	
	/// Initializes a new DataController object
	/// - Parameter inMemory: allows the data to be created and managed in memory,
	/// as opposed to the DB itself. Useful for testing.
	init(inMemory: Bool = false)
	{
		container = NSPersistentCloudKitContainer(name: "Main")
		
		if inMemory
		{ container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null") }
		
		container.loadPersistentStores
		{ storeDescription, error in
			if let error = error
			{ fatalError("Fatal error loading store: \(error.localizedDescription)") }
		}
	}
	
	static var preview: DataController =
	{
		let dataController = DataController(inMemory: true)
		
		do {
			try dataController.createSampleData()
		} catch {
			fatalError("Error creating preview: \(error.localizedDescription)")
		}
		
		return dataController
	}()
	
	func createSampleData()
	throws
	{
		try createSampleData(in: container.viewContext)
	}
	
	func createSampleData(in context: NSManagedObjectContext)
	throws
	{
		let now = Date()
		
		for i in 1...10
		{
			let order = PurchaseOrder(context: context)
			order.id = Int64(i)
			order.status = 1
			order.activeFlag = true
			order.approvalStatus = 1
			order.deliveryNote = Bool.random() ? "Signature required" : "Leave at door"
			order.deviceKey = "iPhoneKey"
			order.issueDate = now.addingTimeInterval(Double.random(in: -720 ... -360))
			order.lastUpdated = now.addingTimeInterval(Double.random(in: -120 ... -60))
			order.lastUpdatedUserEntityId = 0
			order.preferredDeliveryDate = order.lastUpdated!.addingTimeInterval(17280)
			order.purchaseOrderNumber = "#KLS1023"
			order.sentDate = nil
			order.serverTimestamp = 0
			order.supplierId = 1
			
			for j in 1...Int.random(in: 3...10)
			{
				let item = Item(context: context)
				
				item.id = Int64(j)
				item.lastUpdatedUserEntityId = 1
				item.lastUpdated = order.lastUpdated!.addingTimeInterval(Double.random(in: -120 ... 0))
				item.activeFlag = true
				item.productItemId = Int64.random(in: 1 ... Int64.max)
				item.quantity = Int16.random(in: 1 ... 20)
				item.transientIdentifier = "transID\(j)"
				
				item.order = order
			}
			
			for k in 1...3
			{
				let invoice = Invoice(context: context)
				
				invoice.id = Int64(k)
				invoice.transientIdentifier =  "transID\(k)"
				invoice.lastUpdatedUserEntityId = 1
				invoice.lastUpdated = order.lastUpdated!.addingTimeInterval(Double.random(in: -120 ... 0))
				invoice.activeFlag = true
				invoice.created = order.issueDate!
				invoice.invoiceNumber = "#INV\(k)"
				invoice.receiptSentDate = order.issueDate!
				invoice.receivedStatus = 1
				
				for r in 1...Int.random(in: 1...2)
				{
					let receipt = Receipt(context: context)
					
					receipt.id = Int64(r)
					receipt.created = invoice.created!
					receipt.productItemId = Int64.random(in: 1 ... Int64.max)
					receipt.activeFlag = true
					receipt.lastUpdated = invoice.created!
					receipt.lastUpdatedUserEntityId = 1
					receipt.sentDate = invoice.receiptSentDate!
					receipt.receivedQuantity = Int16.random(in: 1 ... 3)
					receipt.transientIdentifier = "transID\(r)"
					
					receipt.invoice = invoice
				}
				
				invoice.order = order
			}
		}
		
		try context.save()
	}
	
	func save()
	{
		if container.viewContext.hasChanges
		{
			do {
				try container.viewContext.save()
			} catch {
				print("Error saving data in context: \(error.localizedDescription)")
			}
		}
	}
	
	private func deleteObject(_ object: NSManagedObject)
	{
		container.viewContext.delete(object)
	}
	
	private func deleteAllInTable(_ table: NSManagedObject.Type)
	{
		let fetchRequest: NSFetchRequest<NSFetchRequestResult> = table.fetchRequest()
		let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		_ = try? container.viewContext.execute(batchDeleteRequest)
	}
	
	private func deleteAll()
	{
		deleteAllInTable(Item.self)
		deleteAllInTable(Receipt.self)
		deleteAllInTable(Invoice.self)
		deleteAllInTable(PurchaseOrder.self)
	}
	
	func delete(_ target: ScopeType)
	{
		switch target
		{
			case .object(let object): deleteObject(object)
			case .allInTable(let table): deleteAllInTable(table)
			case .all: deleteAll()
		}
	}
	
	func delete(_ object: NSManagedObject)
	{
		delete(.object(object))
	}
	
	enum ScopeType
	{
		case all
		case allInTable(NSManagedObject.Type)
		case object(NSManagedObject)
	}
}

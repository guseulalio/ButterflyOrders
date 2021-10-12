//
//  PurchaseOrderTests.swift
//  PurchaseOrderTests
//
//  Created by Gustavo E M Cabral on 12/10/21.
//

import CoreData
import XCTest
@testable import ButterflyOrders

class PurchaseOrderTests
: BaseTestCase
{
    func testCreatingOrdersItemsInvoicesAndReceipts()
	throws
	{
		let targetCount = 10
		for _ in 0..<targetCount
		{
			let order = PurchaseOrder(context: managedObjectContext)
			order.id = Int64.random(in: 1...10000)
			
			for _ in 0..<targetCount
			{
				let item = Item(context: managedObjectContext)
				item.id = Int64.random(in: 1...10000)
				item.quantity = 10
				item.order = order
				
				let invoice = Invoice(context: managedObjectContext)
				invoice.id = Int64.random(in: 1...10000)
				invoice.order = order
				
				let receipt = Receipt(context: managedObjectContext)
				receipt.id = Int64.random(in: 1...10000)
				receipt.invoice = invoice
			}
		}
		
		XCTAssertEqual(dataController.count(for: PurchaseOrder.fetchRequest()), targetCount, "There should be 10 projects")
		XCTAssertEqual(dataController.count(for: Item.fetchRequest()), targetCount * targetCount, "There should be 100 items")
		XCTAssertEqual(dataController.count(for: Invoice.fetchRequest()), targetCount * targetCount, "There should be 100 invoices")
		XCTAssertEqual(dataController.count(for: Receipt.fetchRequest()), targetCount * targetCount, "There should be 100 receipts")
    }
	
	func testDeletingOrders()
	throws
	{
		// Creates data set with 10 purchase orders.
		try dataController.createSampleData()
		
		let request = NSFetchRequest<PurchaseOrder>(entityName: "PurchaseOrder")
		let orders = try managedObjectContext.fetch(request)
		
		dataController.delete(orders[0])
		
		XCTAssertEqual(dataController.count(for: PurchaseOrder.fetchRequest()), 9, "There should be 9 projects")
	}
	
	func testCreatingSampleData()
	throws
	{
		try dataController.createSampleData()
		
		XCTAssertEqual(dataController.count(for: PurchaseOrder.fetchRequest()), 10, "There should be 10 projects")
	}
	
	func testDeletingDataFromOneTable()
	throws
	{
		try dataController.createSampleData()
		
		dataController.delete(.allInTable(Receipt.self))
		XCTAssertNotEqual(dataController.count(for: PurchaseOrder.fetchRequest()), 0, "There should be 10 projects")
		XCTAssertNotEqual(dataController.count(for: Item.fetchRequest()), 0, "There should be some items")
		XCTAssertNotEqual(dataController.count(for: Invoice.fetchRequest()), 0, "There should be some invoices")
		XCTAssertEqual(dataController.count(for: Receipt.fetchRequest()), 0, "There should be no receipts")
		
		dataController.delete(.allInTable(Invoice.self))
		XCTAssertNotEqual(dataController.count(for: PurchaseOrder.fetchRequest()), 0, "There should be 10 projects")
		XCTAssertNotEqual(dataController.count(for: Item.fetchRequest()), 0, "There should be some items")
		XCTAssertEqual(dataController.count(for: Invoice.fetchRequest()), 0, "There should be no invoices")
		
		dataController.delete(.allInTable(Item.self))
		XCTAssertNotEqual(dataController.count(for: PurchaseOrder.fetchRequest()), 0, "There should be 10 projects")
		XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0, "There should be no items")
		
		dataController.delete(.allInTable(PurchaseOrder.self))
		XCTAssertEqual(dataController.count(for: PurchaseOrder.fetchRequest()), 0, "There should be no projects")
	}
	
	func testDeletingAllData()
	throws
	{
		try dataController.createSampleData()
		
		dataController.delete(.all)
		
		XCTAssertEqual(dataController.count(for: PurchaseOrder.fetchRequest()), 0, "There should be no projects")
		XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0, "There should be no items")
		XCTAssertEqual(dataController.count(for: Invoice.fetchRequest()), 0, "There should be no invoices")
		XCTAssertEqual(dataController.count(for: Receipt.fetchRequest()), 0, "There should be no receipts")
	}
}

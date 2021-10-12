//
//  BaseTestCase.swift
//  ButterflyOrdersTests
//
//  Created by Gustavo E M Cabral on 12/10/21.
//

import CoreData
import XCTest
@testable import ButterflyOrders

class BaseTestCase
: XCTestCase
{
	var dataController: DataController!
	var managedObjectContext: NSManagedObjectContext!
	
    override func setUpWithError()
	throws
	{
		dataController = DataController(inMemory: true)
		managedObjectContext = dataController.container.viewContext
    }
}

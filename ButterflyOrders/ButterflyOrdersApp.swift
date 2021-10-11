//
//  ButterflyOrdersApp.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 9/10/21.
//

import CoreData
import SwiftUI

@main
struct ButterflyOrdersApp
: App
{
	@StateObject var dataController: DataController
	
	init()
	{
		let dataController = DataController()
		_dataController = StateObject(wrappedValue: dataController)
		dataController.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
	}
	
    var body: some Scene
	{
        WindowGroup
		{
            OrderListView()
			.environment(\.managedObjectContext, dataController.container.viewContext)
			.environmentObject(dataController)
        }
    }
}

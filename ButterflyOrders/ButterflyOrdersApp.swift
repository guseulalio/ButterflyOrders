//
//  ButterflyOrdersApp.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 9/10/21.
//

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
	}
	
    var body: some Scene
	{
        WindowGroup
		{
            ContentView()
			.environment(\.managedObjectContext, dataController.container.viewContext)
			.environmentObject(dataController)
        }
    }
}

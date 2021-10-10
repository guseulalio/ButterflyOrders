//
//  NetworkManager.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 11/10/21.
//

import Foundation
import CoreData

typealias NetworkManagerCallBack = (Result<[PurchaseOrder], DataFetchingError>) -> Void

class NetworkManager
{
	/// Provides single instance of network manager
	static let shared = NetworkManager()
	
	private let baseURL = "https://my-json-server.typicode.com/butterfly-systems/sample-data/purchase_orders"
	
	var managedObjectContext: NSManagedObjectContext?
	
	/// Initializer is private. To get an instance, use the `shared` property.
	private init() {}
	
	/// Performs a query and hands the results to the `NetworkManagerCallBack` closure.
	/// - Parameters:
	///   - completion: callback closure that handles the results.
	func fetch(completion: @escaping NetworkManagerCallBack)
	{
		if let url = URL(string: baseURL)
		{
			retrieveData(from: url, onCompletion: completion)
		} else {
			print("Error generating URL from string.")
			completion(.failure(.cannotGenerateURLFromString))
		}
	}
	
	private func retrieveData(from url: URL,
					  onCompletion completion: @escaping NetworkManagerCallBack)
	{
		var orders = [PurchaseOrder]()
		
		if let data = try? Data(contentsOf: url)
		{
			if let managedObjectContext = managedObjectContext {
				let decoder = JSONDecoder()
				decoder.userInfo[CodingUserInfoKey.managedObjectContext] = managedObjectContext
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				
				do {
					orders = try decoder.decode([PurchaseOrder].self, from: data)
					completion(.success(orders))
				} catch {
					print("Error decoding data: \(error.localizedDescription)")
					completion(.failure(.cannotDecodeData))
				}
			} else {
				print("Persistent context not set.")
				completion(.failure(.missingManagedObjectContext))
			}
		} else {
			print("Unable to fetch data.")
			completion(.failure(.cannotFetchData))
		}
	}
	
//	func fetch(_ queryType: NetworkManager.QueryType) -> [LocationData]
//	{
//		var locationData = [LocationData]()
//
//		NetworkManager.shared.fetch(query: queryType)
//		{ result in
//			switch result {
//				case .success(let locationList): locationData.append(contentsOf: locationList)
//				case .failure(let error):
//					switch error { case .error(let msg): print("Error: \(msg)") }
//			}
//		}
//
//		return locationData
//	}
}

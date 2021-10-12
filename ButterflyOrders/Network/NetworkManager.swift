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
	
	/// Retrieves the data from the URL
	/// - Parameters:
	///   - url: URL to fetch the data from
	///   - completion: block to be executed on completion of the fetch
	private func retrieveData(from url: URL,
					  onCompletion completion: @escaping NetworkManagerCallBack)
	{
		var orders = [PurchaseOrder]()
		
		if let data = try? Data(contentsOf: url)
		{
			//let dataStr = String(data: data, encoding: String.Encoding.utf8)
			//print("\n\n================")
			//print(dataStr ?? "nothing")
			//print("================\n\n")
			
			if let managedObjectContext = managedObjectContext {
				let decoder = JSONDecoder()
				decoder.userInfo[CodingUserInfoKey.managedObjectContext] = managedObjectContext
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
				decoder.dateDecodingStrategy = .formatted(dateFormatter)
				
				do {
					orders = try decoder.decode([PurchaseOrder].self, from: data)
					try? managedObjectContext.save()
					completion(.success(orders))
				} catch {
					switch error {
						case DecoderError.keyedDecodingError(let key):
							print("Error decoding key `\(key)`")
						default:
							print("Error decoding data: \(error.localizedDescription)")
					}
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
}

//
//  XCodingUserInfoKey.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 10/10/21.
//

import Foundation

extension CodingUserInfoKey
{
	/// Key to allow the managed object context to be used with the Decodable protocol
	static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

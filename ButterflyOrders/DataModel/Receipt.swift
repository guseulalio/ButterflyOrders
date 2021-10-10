//
//  Receipt.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 10/10/21.
//

import CoreData

class Receipt
: NSManagedObject, Codable
{
	enum CodingKeys
	: CodingKey
	{
		case id,
			 created,
			 lastUpdated,
			 lastUpdatedUserEntityId,
			 activeFlag,
			 transientIdentifier,
			 productItemId,
			 receivedQuantity,
			 sentDate
	}
	
	required convenience init(from decoder: Decoder)
	throws
	{
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext
		else {
			throw DecoderError.missingManagedObjectContext
		}
		
		self.init(context: context)
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id 			= try container.decode(Int64.self, forKey: .id)
		self.created 		= try container.decode(Date.self, forKey: .created)
		self.lastUpdated 	= try container.decode(Date.self, forKey: .lastUpdated)
		self.lastUpdatedUserEntityId = try container.decode(Int64.self, forKey: .lastUpdatedUserEntityId)
		self.activeFlag 	= try container.decode(Bool.self, forKey: .activeFlag)
		self.transientIdentifier = try container.decode(String.self, forKey: .transientIdentifier)
		self.productItemId 	= try container.decode(Int64.self, forKey: .productItemId)
		self.receivedQuantity = try container.decode(Int16.self, forKey: .receivedQuantity)
		self.sentDate 		= try container.decode(Date.self, forKey: .sentDate)
	}
	
	func encode(to encoder: Encoder)
	throws
	{
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encode(id, forKey: .id)
		try container.encode(created, forKey: .created)
		try container.encode(lastUpdated, forKey: .lastUpdated)
		try container.encode(lastUpdatedUserEntityId, forKey: .lastUpdatedUserEntityId)
		try container.encode(activeFlag, forKey: .activeFlag)
		try container.encode(transientIdentifier, forKey: .transientIdentifier)
		try container.encode(productItemId, forKey: .productItemId)
		try container.encode(receivedQuantity, forKey: .receivedQuantity)
		try container.encode(sentDate, forKey: .sentDate)
	}
}

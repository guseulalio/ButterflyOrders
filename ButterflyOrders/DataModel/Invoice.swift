//
//  Invoice.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 10/10/21.
//

import CoreData

class Invoice
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
			 transientIdentitier,
			 invoiceNumber,
			 receiptSentDate,
			 receivedStatus,
			 receipts
	}
	
	required convenience init(from decoder: Decoder)
	throws
	{
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext
		else {
			throw DecoderError.missingManagedObjectContext
		}
		
		self.init(context: context)
		
		let container 		= try decoder.container(keyedBy: CodingKeys.self)
		self.id 			= try container.decode(Int64.self, forKey: .id)
		self.created 		= try container.decode(Date.self, forKey: .created)
		self.lastUpdated 	= try container.decode(Date.self, forKey: .lastUpdated)
		self.lastUpdatedUserEntityId = try container.decode(Int64.self, forKey: .lastUpdatedUserEntityId)
		self.activeFlag 	= try container.decode(Bool.self, forKey: .activeFlag)
		self.transientIdentitier = try container.decode(String.self, forKey: .transientIdentitier)
		self.invoiceNumber 	= try container.decode(String.self, forKey: .invoiceNumber)
		self.receiptSentDate = try container.decode(Date.self, forKey: .receiptSentDate)
		self.receivedStatus = try container.decode(Int16.self, forKey: .receivedStatus)
		self.receipts 		= try container.decode(Set<Receipt>.self, forKey: .receipts) as NSSet
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
		try container.encode(transientIdentitier, forKey: .transientIdentitier)
		try container.encode(invoiceNumber, forKey: .invoiceNumber)
		try container.encode(receiptSentDate, forKey: .receiptSentDate)
		try container.encode(receivedStatus, forKey: .receivedStatus)
		try container.encode(receipts as! Set<Receipt>, forKey: .receipts)
	}
}

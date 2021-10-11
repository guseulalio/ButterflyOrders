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
			 transientIdentifier,
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
		try attempt ({ self.id = try container.decode(Int64.self, forKey: .id) }, forKey: "id")
		try attempt ({ self.created = try container.decode(Date.self, forKey: .created) }, forKey: "created")
		try attempt ({ self.lastUpdated = try container.decode(Date.self, forKey: .lastUpdated) }, forKey: "INVOICE.lastUpdated")
		try attempt ({ self.lastUpdatedUserEntityId = try container.decode(Int64.self, forKey: .lastUpdatedUserEntityId) }, forKey: "lastUpdatedUserEntityId")
		try attempt ({ self.activeFlag = try container.decode(Bool.self, forKey: .activeFlag) }, forKey: "activeFlag")
		try attempt ({ self.transientIdentifier = try container.decode(String.self, forKey: .transientIdentifier) }, forKey: "transientIdentifier")
		try attempt ({ self.invoiceNumber = try container.decode(String.self, forKey: .invoiceNumber) }, forKey: "invoiceNumber")
		try attempt ({ self.receiptSentDate = try container.decode(Date.self, forKey: .receiptSentDate) }, forKey: "receiptSentDate")
		try attempt ({ self.receivedStatus = try container.decode(Int16.self, forKey: .receivedStatus) }, forKey: "receivedStatus")
		try attempt ({ self.receipts = try container.decode(Set<Receipt>.self, forKey: .receipts) as NSSet }, forKey: "receipts")
	}
	
	func attempt(_ block: ThrowingBlock, forKey key: String)
	throws
	{
		do { try block() }
		catch {
			print("\n\nError decoding: \(key)\n\n")
			throw DecoderError.keyedDecodingError(key)
		}
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
		try container.encode(invoiceNumber, forKey: .invoiceNumber)
		try container.encode(receiptSentDate, forKey: .receiptSentDate)
		try container.encode(receivedStatus, forKey: .receivedStatus)
		try container.encode(receipts as! Set<Receipt>, forKey: .receipts)
	}
}

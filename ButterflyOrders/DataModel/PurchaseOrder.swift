//
//  PurchaseOrder.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 10/10/21.
//

import CoreData

class PurchaseOrder
: NSManagedObject, Codable
{
	enum CodingKeys
	: CodingKey
	{
		case id,
			 lastUpdated,
			 lastUpdatedUserEntityId,
			 activeFlag,
			 approvalStatus,
			 deliveryNote,
			 deviceKey,
			 issueDate,
			 preferredDeliveryDate,
			 purchaseOrderNumber,
			 sentDate,
			 serverTimestamp,
			 status,
			 supplierId,
			 items,
			 invoices
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
		self.lastUpdated 	= try container.decode(Date.self, forKey: .lastUpdated)
		self.lastUpdatedUserEntityId = try container.decode(Int64.self, forKey: .lastUpdatedUserEntityId)
		self.activeFlag 	= try container.decode(Bool.self, forKey: .activeFlag)
		self.approvalStatus = try container.decode(Int16.self, forKey: .approvalStatus)
		self.deliveryNote 	= try container.decode(String.self, forKey: .deliveryNote)
		self.deviceKey 		= try container.decode(String.self, forKey: .deviceKey)
		self.issueDate 		= try container.decode(Date.self, forKey: .issueDate)
		self.preferredDeliveryDate 	= try container.decode(Date.self, forKey: .preferredDeliveryDate)
		self.purchaseOrderNumber 	= try container.decode(String.self, forKey: .purchaseOrderNumber)
		self.sentDate 		= try container.decode(Date.self, forKey: .sentDate)
		self.serverTimestamp		= try container.decode(Int64.self, forKey: .serverTimestamp)
		self.status 		= try container.decode(Int16.self, forKey: .status)
		self.supplierId 	= try container.decode(Int64.self, forKey: .supplierId)
		self.items 			= try container.decode(Set<Item>.self, forKey: .items) as NSSet
		self.invoices 		= try container.decode(Set<Invoice>.self, forKey: .invoices) as NSSet
	}
	
	func encode(to encoder: Encoder)
	throws
	{
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encode(id, forKey: .id)
		try container.encode(lastUpdated, forKey: .lastUpdated)
		try container.encode(lastUpdatedUserEntityId, forKey: .lastUpdatedUserEntityId)
		try container.encode(activeFlag, forKey: .activeFlag)
		try container.encode(approvalStatus, forKey: .approvalStatus)
		try container.encode(deliveryNote, forKey: .deliveryNote)
		try container.encode(deviceKey, forKey: .deviceKey)
		try container.encode(issueDate, forKey: .issueDate)
		try container.encode(preferredDeliveryDate, forKey: .preferredDeliveryDate)
		try container.encode(purchaseOrderNumber, forKey: .purchaseOrderNumber)
		try container.encode(sentDate, forKey: .sentDate)
		try container.encode(serverTimestamp, forKey: .serverTimestamp)
		try container.encode(status, forKey: .status)
		try container.encode(supplierId, forKey: .supplierId)
		try container.encode(items as! Set<Item>, forKey: .items)
		try container.encode(invoices as! Set<Invoice>, forKey: .invoices)
	}
}

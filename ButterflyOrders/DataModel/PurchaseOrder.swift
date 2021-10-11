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
	
	var itemList: [Item] { items?.allObjects as? [Item] ?? [] }
	var invoiceList: [Invoice] { invoices?.allObjects as? [Invoice] ?? [] }
	var noteForDelivery: String {
		get { return deliveryNote ?? "" }
		set { deliveryNote = newValue }
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
		try attempt ({ self.id = try container.decode(Int64.self, forKey: .id) }, forKey: "id")
		try attempt ({ self.lastUpdated = try container.decode(Date.self, forKey: .lastUpdated) }, forKey: "ORDER.lastUpdated")
		try attempt ({ self.lastUpdatedUserEntityId = try container.decode(Int64.self, forKey: .lastUpdatedUserEntityId) }, forKey: "lastUpdatedUserEntityId")
		try attempt ({ self.activeFlag = try container.decode(Bool.self, forKey: .activeFlag) }, forKey: "activeFlag")
		try attempt ({ self.approvalStatus = try container.decode(Int16.self, forKey: .approvalStatus) }, forKey: "approvalStatus")
		try attempt ({ self.deliveryNote = try container.decode(String.self, forKey: .deliveryNote) }, forKey: "deliveryNote")
		try attempt ({ self.deviceKey = try container.decode(String.self, forKey: .deviceKey) }, forKey: "deviceKey")
		try attempt ({ self.issueDate = try container.decode(Date.self, forKey: .issueDate) }, forKey: "issueDate")
		try attempt ({ self.preferredDeliveryDate = try container.decode(Date.self, forKey: .preferredDeliveryDate) }, forKey: "preferredDeliveryDate")
		try attempt ({ self.purchaseOrderNumber = try container.decode(String.self, forKey: .purchaseOrderNumber) }, forKey: "purchaseOrderNumber")
		try attempt ({ self.sentDate = try container.decode(Date.self, forKey: .sentDate) }, forKey: "sentDate")
		try attempt ({ self.serverTimestamp = try container.decode(Int64.self, forKey: .serverTimestamp) }, forKey: "serverTimestamp")
		try attempt ({ self.status = try container.decode(Int16.self, forKey: .status) }, forKey: "status")
		try attempt ({ self.supplierId = try container.decode(Int64.self, forKey: .supplierId) }, forKey: "supplierId")
		try attempt ({ self.items = try container.decode(Set<Item>.self, forKey: .items) as NSSet }, forKey: "items")
		try attempt ({ self.invoices = try container.decode(Set<Invoice>.self, forKey: .invoices) as NSSet }, forKey: "invoices")
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

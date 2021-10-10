//
//  Errors.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 10/10/21.
//

import Foundation


enum ErrorWithMessage
: Error, Equatable
{ case error(String) }

enum DataFetchingError
: Error
{
	case cannotGenerateURLFromString
	case cannotDecodeData
	case cannotFetchData
	case missingManagedObjectContext
}

enum DecoderError
: Error
{
	case missingManagedObjectContext
}

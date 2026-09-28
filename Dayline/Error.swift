//
//  Error.swift
//  Dayline
//
//  Created by Jibryll Brinkley on 9/28/26.
//

import Foundation

enum QuoteError: Error {
    case invalidURL, invalidResponse, invalidData
}


enum NewsError: Error {
    case invalidURL, invalidResponse, invalidData, missingAPIKey
}

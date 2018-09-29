//
//  HTTPServiceInterface.swift
//  Palette
//
//  Created by Saoirse on 9/29/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

// MARK:- HTTP methods -
public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
    case head   = "HEAD"
    
    /// Methods which support BODY.
    var acceptsBody: Bool {
        switch self {
        case .post, .put:
            return true
        default:
            return false
        }
    }
}

// MARK:- The Result type -
public enum HTTPResult<T> {
    case success(T)
    case failure(Error)
}
public typealias HTTPServiceResult = (HTTPResult<Data>) -> Void


/// HTTP Service Interface
protocol HTTPServiceInterface {
    func performService(withRequest request: URLRequest,
                        with completion: @escaping HTTPServiceResult )
}

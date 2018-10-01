//
//  WebServiceInterface.swift
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

/// MARK:- WebService Result -
/// The Result type:
public enum ServiceResult<T> {
    case success(T)
    case failure(Error)
}
public typealias WebServiceResult = (ServiceResult<Data>) -> Void


// MARK:- Web Service
protocol WebServiceInterface {
     func performService(serviceRequest: ServiceRequest,
                         completion: @escaping WebServiceResult)
}

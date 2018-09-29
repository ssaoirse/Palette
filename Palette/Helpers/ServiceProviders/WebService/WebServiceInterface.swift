//
//  WebServiceInterface.swift
//  Palette
//
//  Created by Saoirse on 9/29/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

/// MARK:- WebService Result -
/// The Result type:
public enum ServiceResult<T> {
    case success(T)
    case failure(String)
}
public typealias WebServiceResult = (ServiceResult<Data>) -> Void


// MARK:- Web Service
protocol WebServiceInterface {
     func performService(serviceRequest: ServiceRequest,
                         completion: @escaping WebServiceResult)
}

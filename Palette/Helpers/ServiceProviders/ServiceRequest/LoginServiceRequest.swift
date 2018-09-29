//
//  LoginServiceRequest.swift
//  Palette
//
//  Created by Saoirse on 9/29/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

/// Login Service Result
public typealias LoginServiceResult = (ServiceResult<String>) -> Void


// MARK:- Login Service Request -
public enum LoginServiceRequest {
    case login( username: String, password: String)
    
}

// MARK:- Extension - Service Request -
extension LoginServiceRequest: ServiceRequest {
    
    /// Absolute Path:
    public var absolutePath: String {
        switch self {
        case .login:
            return "\(URLConstants.kServerBaseURL)\(URLConstants.kLoginServicePath)"
        }
    }
    
    /// HTTP Method
    public var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    /// HTTP Headers: Uses default request header.
    
    
    /// Query Parameters:
    public var queryParams: [URLQueryItem]? {
        switch self {
        case .login:
            return nil
        }
    }
    
    /// Parameters:
    public var bodyParams: JSONDictionary? {
        switch self {
        case .login(let username, let password):
            var dictionary = JSONDictionary()
            dictionary["username"] = username
            dictionary["password"] = password
            return dictionary
        }
    }
}

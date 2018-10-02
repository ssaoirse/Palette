//
//  ColorPaletteServiceRequest.swift
//  Palette
//
//  Created by Saoirse on 9/30/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

// MARK:- ColorPalette Service Request -
public enum ColorPaletteServiceRequest {
    case fetchBackgroundColor(requestId: Int, authToken: String)
    case saveBackgroundColor(requestId: Int, selectedColor: PaletteColor, authToken: String)
}

// MARK:- Extension - Service Request -
extension ColorPaletteServiceRequest: ServiceRequest {
    
    /// Absolute Path:
    public var absolutePath: String {
        switch self {
        case .fetchBackgroundColor(let requestId, _):
            return "\(URLConstants.kServerBaseURL)\(URLConstants.kStorageServicePath)/\(requestId)"
        case .saveBackgroundColor(let requestId, _, _):
            return "\(URLConstants.kServerBaseURL)\(URLConstants.kStorageServicePath)/\(requestId)"
        }
    }
    
    /// HTTP Method
    public var httpMethod: HTTPMethod {
        switch self {
        case .fetchBackgroundColor:
            return .get
        case .saveBackgroundColor:
            return .put
        }
    }
    
    /// HTTP Headers
    public var headers: HTTPHeaders? {
        var headers = ["Content-Type": "application/json; charset=utf-8"]
        switch self {
        case .fetchBackgroundColor(_, let authToken),
             .saveBackgroundColor(_, _, let authToken):
            headers["Authorization"] = authToken
        }
        return headers
    }
    
    
    /// Query Parameters:
    public var queryParams: [URLQueryItem]? {
        switch self {
        case .fetchBackgroundColor, .saveBackgroundColor:
            return nil
        }
    }
    
    /// Parameters:
    public var bodyParams: JSONDictionary? {
        switch self {
        case .fetchBackgroundColor:
            return nil
        case .saveBackgroundColor(_, let selectedColor, _):
            var parameters = JSONDictionary()
            parameters["data"] = selectedColor.toDictionary()
            return parameters
        }
    }
}

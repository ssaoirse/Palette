//
//  HTTPServiceProvider.swift
//  Palette
//
//  Created by Saoirse on 9/29/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

/// Conforms to the HTTPService Protocol
struct HTTPServiceProvider: HTTPServiceInterface {
    
    /// DI url Session.
    private let urlSession: URLSession
        
    /// Initializer:
    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
        
    /*!
     * @brief Peforms an HTTP service request and passes the result in the completion block.
     * @param  request                  A URLRequest object which has the required resource path, query paramters etc.
     * @param  completion               A completion closure which passes the completion response as HTTPServiceResult.
     */
    public func performService(withRequest request: URLRequest,
                               with completion: @escaping HTTPServiceResult ) {
        urlSession.dataTask(with: request) { (data, response, error) in
            // Handle error.
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Validate HTTP Status code.
            guard let httpResponse = response as? HTTPURLResponse else {
                let err = NSError(domain: "com.gaiainc.Palette",
                                  code: -1000,
                                  userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response."])
                completion(.failure(err))
                return
            }
            
            // Check if HTTP response is valid.
            if let httpError = self.getHTTPServiceError(fromResponse: httpResponse) {
                completion(.failure(httpError))
                return
            }
            
            // Validate Data.
            guard let data = data else {
                completion(.failure(NSError(domain: "com.gaiainc.Palette",
                                            code: -1001,
                                            userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response data."])))
                return
            }
            
            // notify success.
            completion(.success(data))
            return
        }.resume()
    }
        
        
    /// Parses the HTTP response and gets the status code and error.
    fileprivate func getHTTPServiceError(fromResponse response: HTTPURLResponse) -> Error? {
        var error: Error?
        switch response.statusCode {
        case 200...299:
            error = nil
        default:
            let errorDescription = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
            error = NSError(domain: "com.gaiainc.Palette",
                            code: response.statusCode,
                            userInfo: [NSLocalizedDescriptionKey: errorDescription])
        }
        return error
    }
}

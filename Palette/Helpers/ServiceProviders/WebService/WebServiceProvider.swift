//
//  WebServiceProvider.swift
//  Palette
//
//  Created by Saoirse on 9/29/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

/// Conforms to the WebService Interface.
class WebServiceProvider: WebServiceInterface {
    private let urlSession: URLSession
    
    /// Initializer:
    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    /*!
     * @brief Performs an HTTP WebService Request.
     * @param  serviceRequest               The service request which encapsulates the resource, method, parameters etc.
     * @param  completion                   The completion block which returns the WebServiceResult.
     */
    public func performService(serviceRequest: ServiceRequest,
                               completion: @escaping WebServiceResult)
    {
        // Validate input service path.
        guard let url = URL(string: serviceRequest.absolutePath) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = serviceRequest.httpMethod.rawValue
        addRequestHeaders(serviceRequest.headers, request: &request)
        if let queryParams = serviceRequest.queryParams {
            addQueryItems(queryParams, to: &request)
        }
        
        // Add Body.
        if serviceRequest.httpMethod.acceptsBody {
            addRequestBody(serviceRequest.bodyParams, request: &request)
        }
        
        // Initiate http request.
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
    
    /*!
     * @brief Adds Query Parameters if any to the Request.
     * @param  queryItems                   An array of name value pairs to be passed as query items.
     * @param  request                      A reference to the URLRequest.
     */
    fileprivate func addQueryItems(_ queryItems: [URLQueryItem] = [],
                                   to request: inout URLRequest) {
        if queryItems.isEmpty {
            return
        }
        guard let url = request.url else { return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        if let modifiedURL = components?.url {
            request.url = modifiedURL
        }
    }
    
    
    /// Add Request Headers.
    /*!
     * @brief Add Request Headers if any to the Request.
     * @param  httpHeaders                  An array of name value pairs to be passed HTTP headers
     * @param  request                      A reference to the URLRequest.
     */
    fileprivate func addRequestHeaders(_ httpHeaders: HTTPHeaders?,
                                       request: inout URLRequest) {
        guard let headers = httpHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    /*!
     * @brief Add JSON request body.
     */
    fileprivate func addRequestBody( _ parameters: JSONDictionary?,
                                     request: inout URLRequest) {
        // Add body
        if let parameters = parameters,
            let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = body
        }
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

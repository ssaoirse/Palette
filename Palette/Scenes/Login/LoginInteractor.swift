//
//  LoginInteractor.swift
//  Palette
//
//  Created by Saoirse on 9/29/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

/// The Interactor.
class LoginInteractor {
    private let webServiceProvider: WebServiceInterface
    
    init(webServiceProvider: WebServiceInterface) {
        self.webServiceProvider = webServiceProvider
    }
}


// MARK:- Login Business Logic
extension LoginInteractor: LoginBusinessLogic {
    
    func login(with userName: String, password: String) {
        let request = LoginServiceRequest.login(username: userName, password: password)
        webServiceProvider.performService(serviceRequest: request) { (result) in
            switch result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                do {
                    let serviceResponse = try jsonDecoder.decode(LoginResponseModel.self, from: data)
                    // success.
                    print(serviceResponse.token)
                    return
                }
                catch {
                    print(error)
                    return
                }
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
}

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
    private var loginView: LoginViewInterface? = nil
    
    init(webServiceProvider: WebServiceInterface,
         loginView: LoginViewInterface? = nil) {
        self.webServiceProvider = webServiceProvider
        self.loginView = loginView
    }
}


// MARK:- Login Business Logic
extension LoginInteractor: LoginBusinessLogic {
    
    func login(with userName: String, password: String) {
        
        // TODO: Validate username and password.
        
        
        let request = LoginServiceRequest.login(username: userName, password: password)
        webServiceProvider.performService(serviceRequest: request) { [weak self] (result) in
            switch result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                do {
                    let serviceResponse = try jsonDecoder.decode(LoginResponseModel.self, from: data)
                    // success.
                    print(serviceResponse.token)
                    self?.loginView?.navigateToColorPalette()
                    return
                }
                catch {
                    print(error)
                    self?.loginView?.showLoginError(with: error.localizedDescription)
                    return
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.loginView?.showLoginError(with: error.localizedDescription)
                return
            }
        }
    }
}

//
//  LoginInterfaces.swift
//  Palette
//
//  Created by Saoirse on 9/29/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//
import Foundation


/// Interactor:
protocol LoginBusinessLogic {
    func login(with userName: String, password: String) 
}

/// View:
protocol LoginViewInterface {
    /// On Login Error.
    func showLoginError(with message: String)
    /// On Login Success
    func navigateToColorPalette()
}

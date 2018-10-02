//
//  LoginViewController.swift
//  Palette
//
//  Created by Saoirse on 9/29/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, HasDependencies {

    private lazy var webServiceProvider: WebServiceInterface = dependencies.resolveWebService()
    private lazy var loginInteractor: LoginBusinessLogic = LoginInteractor(webServiceProvider: webServiceProvider,
                                                                           loginView: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DispatchQueue.main.async {
            self.doLogin()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func doLogin() {
        self.loginInteractor.login(with: "fstester", password: "FStst313")
    }
}


// MARK:- LoginViewInterface
extension LoginViewController: LoginViewInterface {
    
    func showLoginError(with message: String) {
        print("Login Error: \(message)")
    }
    
    func navigateToColorPalette() {
        print("Login Complete")
    }
}



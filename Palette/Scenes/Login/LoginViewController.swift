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
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // DEBUG:
        self.userNameTextField.text = "fstester"
        self.passwordTextField.text = "FStst313"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginTouchUpInside(_ sender: UIButton) {
        self.view.endEditing(true)
        let uname = self.userNameTextField.text ?? ""
        let passwd = self.passwordTextField.text ?? ""
        self.loginInteractor.login(with: uname, password: passwd)
    }
    
    @IBAction func onResetTouchUpInside(_ sender: UIButton) {
        self.userNameTextField.text = ""
        self.passwordTextField.text = ""
    }
}


// MARK:- LoginViewInterface
extension LoginViewController: LoginViewInterface {
    
    func showLoginError(with message: String) {
        print("Login Error: \(message)")
    }
    
    func navigateToColorPalette() {
        print("Login Complete")
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "ColorPaletteViewController") as! ColorPaletteViewController
            nextVC.title = "Color Palette"
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}



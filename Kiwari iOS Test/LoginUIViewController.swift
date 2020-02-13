//
//  SignInUIViewController.swift
//  Kiwari iOS Test
//
//  Created by Rasyid Respati Wiriaatmaja on 12/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import UIKit
import ProgressHUD
import FirebaseAuth

extension LoginViewController {
    
    func setupTextfields() {
        tfEmailLogin.borderStyle = UITextField.BorderStyle.roundedRect
        tfPasswordLogin.borderStyle = UITextField.BorderStyle.roundedRect
        signInBar.layer.cornerRadius = 5
        dontHaveBar.layer.cornerRadius = 5
        
    }
    
    //Textfields form validation
    func tfValidate() {
        guard let email = self.tfEmailLogin.text, !email.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            return
        }
        guard let password = self.tfPasswordLogin.text, !password.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            return
        }
        
        
    }
    
    func signIn(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        ProgressHUD.show()
        Api.User.signIn(email: self.tfEmailLogin.text!, password: self.tfPasswordLogin.text!, onSuccess: {
            ProgressHUD.dismiss()
            onSuccess()
        }) { (errorMessage) in
            onError(errorMessage)
        }
    }
}

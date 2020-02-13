//
//  ViewController.swift
//  Kiwari iOS Test
//
//  Created by Rasyid Respati Wiriaatmaja on 10/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class LoginViewController: UIViewController {
    
    var userDefaultLogin = UserDefaults.standard
    
    @IBOutlet weak var lblSignIn: UILabel!
    @IBOutlet weak var tfEmailLogin: UITextField!
    @IBOutlet weak var tfPasswordLogin: UITextField!
    @IBOutlet weak var signInBar: UIButton!
    @IBOutlet weak var dontHaveBar: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginUI()

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupLoginUI() {
        setupTextfields()
        
    }
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        self.view.endEditing(true)
        self.tfValidate()
        self.signIn(onSuccess: {
            
            //switching view
            self.userDefaultLogin.set(true, forKey: "isLogin")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destination = storyboard.instantiateViewController(withIdentifier: "navMenu")
            self.show(destination, sender: self)
            
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
        
    }
    
    
    
    func showAlert(title: String, message: String, isFinish: Bool) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var ok = UIAlertAction()
        if isFinish {
            ok = UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) in
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
}


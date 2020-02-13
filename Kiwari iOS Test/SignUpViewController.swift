//
//  SignUpViewController.swift
//  Kiwari iOS Test
//
//  Created by Rasyid Respati Wiriaatmaja on 11/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var tfFullname: UITextField!
    @IBOutlet weak var tfEmailRegis: UITextField!
    @IBOutlet weak var tfPasswordRegis: UITextField!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var signUpBar: UIButton!
    
    var image : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignUpUI()
        
    }
    
    //Back to Login Page
    @IBAction func dismissCancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
    }
    
    //Setting up the UI
    func setupSignUpUI() {
        setupTextfields()
        setupAvatar()
        
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        self.view.endEditing(true)
        self.tfValidate()
        self.signUp(onSuccess: {
            //switching view
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destination = storyboard.instantiateViewController(withIdentifier: "login")
            self.show(destination, sender: self)
            
//            self.dismiss(animated: true, completion: nil)
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    
    }
}

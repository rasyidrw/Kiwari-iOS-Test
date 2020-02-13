//
//  SignUpUIViewController.swift
//  Kiwari iOS Test
//
//  Created by Rasyid Respati Wiriaatmaja on 12/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import UIKit
import ProgressHUD
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

extension SignUpViewController {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func signUp(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        ProgressHUD.show()
        Api.User.signUp(withUsername: self.tfFullname.text!, email: self.tfEmailRegis.text!, password: self.tfPasswordRegis.text!, image: self.image, onSuccess: {
            
            ProgressHUD.showSuccess("Registrasi berhasil. Silahkan Login!")
            onSuccess()
            
        }) { (errorMessage) in
            onError(errorMessage)
        }
        
    }
    
    //Textfields form validation
    func tfValidate() {
        guard let fullname = self.tfFullname.text, !fullname.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_USERNAME)
            return
        }
        guard let email = self.tfEmailRegis.text, !email.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            return
        }
        guard let password = self.tfPasswordRegis.text, !password.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            return
        }
        
    }
    
    func setupTextfields() {
        tfFullname.borderStyle = UITextField.BorderStyle.roundedRect
        tfEmailRegis.borderStyle = UITextField.BorderStyle.roundedRect
        tfPasswordRegis.borderStyle = UITextField.BorderStyle.roundedRect
        signUpBar.layer.cornerRadius = 5
        
    }
    
    func setupAvatar() {
        imageAvatar.layer.cornerRadius = 25
        imageAvatar.clipsToBounds = true
        imageAvatar.isUserInteractionEnabled = true
        
        let pressedAvatar = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        imageAvatar.addGestureRecognizer(pressedAvatar)
        
    }
    
    @objc func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    
}

//Setting up the avatar image picker
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image  = imageSelected
            imageAvatar.image = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = imageOriginal
            imageAvatar.image = imageOriginal
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

//
//  UserApi.swift
//  Kiwari iOS Test
//
//  Created by Rasyid Respati Wiriaatmaja on 11/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD

class UserApi {
    
    func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            print(authData?.user.uid)
            onSuccess()
        }
    }
    
    func signUp(withUsername username: String, email: String, password: String, image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        //Firebase business logic and method
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            if let authData = authDataResult {
                print(authData.user.email!)
                
                let dict : Dictionary <String, Any> = [
                    UID: authData.user.uid,
                    EMAIL: authData.user.email,
                    USERNAME: username,
                    PROFILE_IMAGE_URL: ""
                ]
                
                guard let imageSelected = image else {
                    ProgressHUD.showError(ERROR_EMPTY_PHOTO)
                    return
                }
                
                guard let imageData =  imageSelected.jpegData(compressionQuality: 0.4) else {
                    return
                }
                
                //Setting up the storage for uploaded images
                let storageProfile = Ref().storageSpecificProfile(uid: authData.user.uid)
                
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpg"
                
                StorageService.saveImage(username: username, uid: authData.user.uid, data: imageData, metaData: metaData, storageProfileRef: storageProfile, dict: dict, onSuccess: {
                    onSuccess()
                }, onError: { (errorMessage) in
                    onError(errorMessage)
                })
                
                
            }
        }
        
    }
}

//
//  StorageService.swift
//  Kiwari iOS Test
//
//  Created by Rasyid Respati Wiriaatmaja on 12/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import ProgressHUD

class StorageService {
    static func saveImage(username: String, uid: String, data: Data, metaData: StorageMetadata, storageProfileRef: StorageReference, dict: Dictionary<String, Any>, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        storageProfileRef.putData(data, metadata: metaData) { (storageMetaData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storageProfileRef.downloadURL { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges(completion: { (error) in
                            if let error = error {
                                ProgressHUD.showError(error.localizedDescription)
                            }
                        })
                    }
                    
                    var dictTemp = dict
                    dictTemp[PROFILE_IMAGE_URL] = metaImageUrl
                    
                    //Update the database
                    Ref().databaseSpecificUser(uid: uid).updateChildValues(dictTemp, withCompletionBlock: { (error, ref) in
                        if error == nil {
                            onSuccess()
                        } else {
                            onError(error!.localizedDescription)
                        }
                    })
                }
            }
        }
        
        
    }
    
}

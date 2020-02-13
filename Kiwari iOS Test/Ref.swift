//
//  Ref.swift
//  Kiwari iOS Test
//
//  Created by Rasyid Respati Wiriaatmaja on 12/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase

let REF_USER = "users"
let URL_STORAGE_ROOT = "gs://kiwari-ios-project.appspot.com"
let STORAGE_PROFILE = "profile"
let PROFILE_IMAGE_URL = "profileImageUrl"
let UID = "uid"
let EMAIL = "email"
let USERNAME = "username"
let ERROR_EMPTY_PHOTO = "Pilih gambar untuk profile anda"
let ERROR_EMPTY_EMAIL = "Isi email anda"
let ERROR_EMPTY_PASSWORD = "Isi password anda"
let ERROR_EMPTY_USERNAME = "Isi nama lengkap anda"

class Ref {
    let databaseRoot: DatabaseReference = Database.database().reference()
    
    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
        
    }
    
    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }
    
    //Storage Ref
    let storageRoot = Storage.storage().reference(forURL: URL_STORAGE_ROOT)
    
    var storageProfile: StorageReference {
        return storageRoot.child(STORAGE_PROFILE)
        
    }
    
    func storageSpecificProfile(uid: String) -> StorageReference {
        return storageProfile.child(uid)
        
    }


}

//
//  ChatsTableViewController.swift
//  Kiwari iOS Test
//
//  Created by Rasyid Respati Wiriaatmaja on 10/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import UIKit
import Firebase

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

class ChatsTableViewController: UITableViewController {
    
    
    
    var userDefaultLogin : UserDefaults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDefaultLogin = UserDefaults.standard
        
        let isLogin : Bool = (userDefaultLogin?.bool(forKey: "isLogin"))!
        
        if isLogin {
            
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                print(snapshot)
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionary["username"] as? String
                }
                
                
            }, withCancel: nil)
            print("sudah login")
            
        } else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destination = storyboard.instantiateViewController(withIdentifier: "login")
            self.show(destination, sender: self)
        }
        
        tableView.register(UserCell.self, forCellReuseIdentifier: "idCell")
        observeMessages()
        
    }
    
    var messages = [Message]()
        var messagesDictionary = [String: Message]()
        
        func observeMessages() {
            let ref = Database.database().reference().child("messages")
            ref.observe(.childAdded, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let message = Message(dictionary: dictionary)
    //                self.messages.append(message)
                    
                    if let toId = message.toId {
                        self.messagesDictionary[toId] = message
                        
                        self.messages = Array(self.messagesDictionary.values)
                        self.messages.sort(by: { (message1, message2) -> Bool in
                            
                            return message1.timestamp?.int32Value > message2.timestamp?.int32Value
                        })
                    }
                    
                    //this will crash because of background thread, so lets call this on dispatch_async main thread
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }
                
                }, withCancel: nil)
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! CellUser
        
        let message = messages[indexPath.row]
        cell.message = message
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    
    
    @IBAction func btnComposeChat(_ sender: UIBarButtonItem) {
        
        let newMessageController = NewMessageTableViewController()
        present(newMessageController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnLogout(_ sender: UIBarButtonItem) {
        
//        do {
//            try Auth.auth().signOut()
//
//            let loginPage = LoginViewController()
//            let loginNavigation = UINavigationController(rootViewController: loginPage)
//            self.present(loginNavigation, animated: true, completion: nil)
//
//        } catch let err {
//            print("signout failed", err)
//        }
        
        userDefaultLogin?.removeObject(forKey: "isLogin")

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "login")
        present(destination, animated: true, completion: nil)
    }
    
    func showChatControllerForUser(_ user: User) {
        let chatPersonController = ChatLogTableViewController(collectionViewLayout: UICollectionViewFlowLayout())
        chatPersonController.user = user
        navigationController?.pushViewController(chatPersonController, animated: true)
        
    }
    
    
    
    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

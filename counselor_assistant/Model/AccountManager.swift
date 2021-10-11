//
//  AccountManager.swift
//  counselor_assistant
//
//  Created by Yi Xu on 10/10/21.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore


class AccountManager {
    private var myAccount = AccountModel.sharedInstance
    static let sharedInstance = AccountManager();
    let db = Firestore.firestore();
    
    func setUserAdminPriveledge(gmail: String, priviledge: Bool) {
        self.db.collection("Accounts").document(gmail).setData([
            "gmail": gmail,
            "isAdmin": priviledge
        ]) { (error) in
                if error != nil{
                    print("Error in Account")
                }
            }
    }
    
    
    func registerMyAccount(account: AccountModel){
        guard let gmail = account.gmail else {
            return
        }
        let docRef = db.collection("Accounts").document(gmail)
        docRef.getDocument { (document, error) in
            
            if let document = document, document.exists {
                let accountObj = document.data() as [String: AnyObject]?
                self.myAccount.isAdmin = (accountObj?["isAdmin"] as! NSNumber) != 0
                print(self.myAccount.isAdmin)
                return
            } else {
                self.updateAccount(account: account)
            }
        }
        
    }
    
    private func updateAccount(account: AccountModel) {
        guard let gmail = account.gmail else {
            return
        }
        self.db.collection("Accounts").document(gmail).setData([
            "gmail": gmail,
            "isAdmin": account.isAdmin
        ]) { (error) in
                if error != nil{
                    print("Error in Account")
                }
            }
    }
    
    
}

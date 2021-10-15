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

protocol AdminSignInDelegate{
     func didFetchData(data: Bool)
}


class AccountManager {
    private static var myAccount = AccountModel.sharedInstance
    static let db = Firestore.firestore()
    
    
    static func loginAccordingToPriveledge(gmail: String, vc: AdminSignInDelegate) {

        let docRef = AccountManager.db.collection("Accounts").document(gmail)

        docRef.getDocument { (document, error) in

            if let document = document, document.exists {
                let accountObj = document.data() as [String: AnyObject]?
                if ((accountObj?["isAdmin"] as! NSNumber) != 0) {
                    vc.didFetchData(data: true)
                } else {
                    vc.didFetchData(data: false)
                }
                
            }
            
        }

    }
    
    static func setUserAdminPriveledge(gmail: String, priviledge: Bool) {
        AccountManager.db.collection("Accounts").document(gmail).setData([
            "gmail": gmail,
            "isAdmin": priviledge
        ]) { (error) in
                if error != nil{
                    print("Error in Account")
                }
            }
    }
    
    
    static func registerMyAccount(account: AccountModel){
        guard let gmail = account.gmail else {
            return
        }
        let docRef = AccountManager.db.collection("Accounts").document(gmail)
        docRef.getDocument { (document, error) in
            
            if let document = document, document.exists {
                let accountObj = document.data() as [String: AnyObject]?
                AccountManager.myAccount.isAdmin = (accountObj?["isAdmin"] as! NSNumber) != 0
                // Create an empty collection of VisitRecords.
                print(AccountManager.myAccount.isAdmin)
                return
            } else {
                AccountManager.updateAccount(account: account)
            }
        }
        
    }
    
    private static func updateAccount(account: AccountModel) {
        guard let gmail = account.gmail else {
            return
        }
        AccountManager.db.collection("Accounts").document(gmail).setData([
            "gmail": gmail,
            "isAdmin": account.isAdmin
        ]) { (error) in
                if error != nil{
                    print("Error in Account")
                }
            }
    }
    
    
}

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
    private var existingAccountEmails = Set<String>()
    static let sharedInstance = AccountManager();
    let db = Firestore.firestore();
    
    private func loadAccounts()  {
        let accountRef = db.collection("Accounts")
        accountRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let actualquery = querySnapshot{
                    if !actualquery.isEmpty{
                        for document in querySnapshot!.documents {
                            let accountObj = document.data() as [String: AnyObject]
                            guard let gmail = (accountObj["gmail"] as? String) else {
                                continue
                            }
                            self.existingAccountEmails.insert(gmail)
                        }
                    }
                }
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
                self.db.collection("Accounts").document(gmail).setData([
                    "gmail": gmail,
                    "isAdmin": account.isAdmin,
                    "isSigned": account.isSigned,
                ]) { (error) in
                        if error != nil{
                            print("Error in AddNewBillableCode")
                        }
                    }
            }
        }
        
        
        
    }
    
    
    
}

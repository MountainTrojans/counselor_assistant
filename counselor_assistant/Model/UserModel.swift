//
//  UserModel.swift
//  counselor_assistant
//
//  Created by Albert on 2021/11/1.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

protocol UserDelagate {
    func didFetchUser(data: [String])
}

class UserModel {
    static func getUser(vc: UserDelagate) {
        print("Getting all users")
        let db = Firestore.firestore();
        var users = [String]()
        let userRef = db.collection("Accounts")
        userRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let actualquery = querySnapshot{
                    if !actualquery.isEmpty{
                        for document in querySnapshot!.documents {
                            let userObj = document.data() as [String: AnyObject]
                            users.append(userObj["gmail"] as? String ?? "")
                        }
                        vc.didFetchUser(data: users)
                    }
                }
            }
        }
    }
}

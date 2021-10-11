//
//  BillableCode.swift
//  counselor_assistant
//
//  Created by Yi Xu on 10/9/21.
//

import Foundation
import FirebaseAuth
import Firebase

class BillableCodeModel {
    
    
    static func addNewBillableCode(name: String){
        let db = Firestore.firestore();
        let randomID = UUID.init().uuidString
        db.collection("BillableCode").document(randomID).setData([
            "billableCodeName": name
        ]) { (error) in
                if error != nil{
                    print("Error in AddNewBillableCode")
                }
            }
    }
    
        
    static func getBillableCode() -> [String] {
        let db = Firestore.firestore();
        var billableCode = [String]()
        let billableCodeRef = db.collection("BillableCode")
        billableCodeRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let actualquery = querySnapshot{
                    if !actualquery.isEmpty{
                        for document in querySnapshot!.documents {
                            let billableCodeObj = document.data() as? [String: AnyObject]
                            let name = billableCodeObj?["billableCodeName"]
                            billableCode.append(name as! String)
                        }
                    }
                }
            }
        }
        return billableCode
    }
    
    func addNewNonBillableCode(name: String){
        let db = Firestore.firestore();
        let randomID = UUID.init().uuidString
        db.collection("NonBillableCode").document(randomID).setData([
            "nonBillableCodeName": name
        ]) { (error) in
                if error != nil{
                    print("Error in AddNewNonBillableCode")
                }
            }
    }
    
        
    func getNonBillableCode() -> [String] {
        let db = Firestore.firestore();
        var nonBillableCode = [String]()
        let nonBillableCodeRef = db.collection("NonBillableCode")
        nonBillableCodeRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let actualquery = querySnapshot{
                    if !actualquery.isEmpty{
                        for document in querySnapshot!.documents {
                            let nonBillableCodeObj = document.data() as? [String: AnyObject]
                            let name = nonBillableCodeObj?["nonBillableCodeName"]
                            nonBillableCode.append(name as! String)
                        }
                    }
                }
            }
        }
        return nonBillableCode
    }
    
}

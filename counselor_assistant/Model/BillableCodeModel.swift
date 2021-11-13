//
//  BillableCode.swift
//  counselor_assistant
//
//  Created by Yi Xu on 10/9/21.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

protocol BillableCodeDelagate {
    func didFetchBillableCode(data: [BillableCode]);
    func didEditBillableCode();
    func didRemoveBillableCodeCode();
}


protocol NonBillableCodeDelegate {
    func didFetchNonBillableCode(data: [String])
}


class BillableCodeModel {
    static let db = Firestore.firestore();
    
    static func addNewBillableCode(billableCode: BillableCode, vc: BillableCodeDelagate){
        
        BillableCodeModel.db.collection("BillableCode").document(billableCode.randomID).setData([
            "billableCodeName": billableCode.billableCode,"costPerHour":billableCode.costPerHour, "description":billableCode.description
        ]) { (error) in
                if error != nil{
                    print("Error in AddNewBillableCode")
                } else {
                    vc.didEditBillableCode()
                }
            }
    }
    
    static func deleteBillableCode(billableCode: BillableCode, vc: BillableCodeDelagate) {
        db.collection("BillableCode").document(billableCode.randomID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                vc.didRemoveBillableCodeCode()
                print("Document successfully removed!")
            }
        }
    }
    
    
        
    static func getBillableCode(vc: BillableCodeDelagate) {
        print("Getting all billable codes")
        let db = Firestore.firestore();
        var billableCodes = [BillableCode]()
        let billableCodeRef = BillableCodeModel.db.collection("BillableCode")
        billableCodeRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let actualquery = querySnapshot{
                    if !actualquery.isEmpty{
                        for document in querySnapshot!.documents {
                            let billableCodeObj = document.data() as [String: AnyObject]
                            billableCodes.append(BillableCode(billableCode:billableCodeObj["billableCodeName"] as? String,costPerHour: billableCodeObj["costPerHour"] as? Int, description: billableCodeObj["description"] as? String, randomID: document.documentID))
                        }
                        vc.didFetchBillableCode(data: billableCodes)
                    }
                }
            }
        }
        
    }
    
    static func addNewNonBillableCode(name: String){
        let randomID = UUID.init().uuidString
        BillableCodeModel.db.collection("NonBillableCode").document(randomID).setData([
            "nonBillableCodeName": name
        ]) { (error) in
                if error != nil{
                    print("Error in AddNewNonBillableCode")
                }
            }
    }
    
        
    static func getNonBillableCode(vc: NonBillableCodeDelegate) {
        var nonBillableCodes = [String]()
        let nonBillableCodeRef = BillableCodeModel.db.collection("NonBillableCode")
        nonBillableCodeRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let actualquery = querySnapshot{
                    if !actualquery.isEmpty{
                        for document in querySnapshot!.documents {
                            let nonBillableCodeObj = document.data() as [String: AnyObject]
                            let name = nonBillableCodeObj["nonBillableCodeName"]
                            nonBillableCodes.append(name as! String)
                            print("!!",name as! String)
                        }
                        vc.didFetchNonBillableCode(data: nonBillableCodes)
                    }
                }
            }
        }
        
    }
    
}

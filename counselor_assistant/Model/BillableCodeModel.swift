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

protocol codeAcquiredDelegate {
    func didFetchCode(data: [BillableCode]);
}

protocol nonCodeAcquiredDelegate {
    func didFetchCode(data: [String])
}


class BillableCodeModel {
    static let db = Firestore.firestore();
    
    static func addNewBillableCode(billableCode: BillableCode){
        
        BillableCodeModel.db.collection("BillableCode").document(billableCode.randomID).setData([
            "billableCodeName": billableCode.billableCode,"costPerHour":billableCode.costPerHour, "description":billableCode.description
        ]) { (error) in
                if error != nil{
                    print("Error in AddNewBillableCode")
                }
            }
    }
    
    static func deleteBillableCode(billableCode: BillableCode) {
        db.collection("BillableCode").document(billableCode.randomID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    
        
    static func getBillableCode(vc: codeAcquiredDelegate) {
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
                            billableCodes.append(BillableCode(billableCode:billableCodeObj["billableCodeName"] as? Int,costPerHour: billableCodeObj["costPerHour"] as? Int, description: billableCodeObj["description"] as? String, randomID: document.documentID))
                        }
                        vc.didFetchCode(data: billableCodes)
                    }
                }
            }
        }
        
    }
    
    func addNewNonBillableCode(name: String){
        let randomID = UUID.init().uuidString
        BillableCodeModel.db.collection("NonBillableCode").document(randomID).setData([
            "nonBillableCodeName": name
        ]) { (error) in
                if error != nil{
                    print("Error in AddNewNonBillableCode")
                }
            }
    }
    
        
    func getNonBillableCode(vc: nonCodeAcquiredDelegate) {
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
                        }
                        vc.didFetchCode(data: nonBillableCodes)
                    }
                }
            }
        }
        
    }
    
}

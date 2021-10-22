//
//  BillableCode.swift
//  counselor_assistant
//
//  Created by Yi Xu on 10/9/21.
//

import Foundation
import FirebaseAuth
import Firebase

protocol codeAcquiredDelegate {
    func didFetchCode(data: [BillableCode]);
}

protocol nonCodeAcquiredDelegate {
    func didFetchCode(data: [String])
}

class BillableCodeModel {
    static func addNewBillableCode(billableCode: BillableCode){
        let db = Firestore.firestore();
        let randomID = UUID.init().uuidString
        db.collection("BillableCode").document(randomID).setData([
            "billableCodeName": billableCode.billableCode,"costPerHour":billableCode.costPerHour
        ]) { (error) in
                if error != nil{
                    print("Error in AddNewBillableCode")
                }
            }
    }
    
        
    static func getBillableCode(vc: codeAcquiredDelegate) {
        print("Getting all billable codes")
        let db = Firestore.firestore();
        var billableCodes = [BillableCode]()
        let billableCodeRef = db.collection("BillableCode")
        billableCodeRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let actualquery = querySnapshot{
                    if !actualquery.isEmpty{
                        for document in querySnapshot!.documents {
                            let billableCodeObj = document.data() as [String: AnyObject]
                            billableCodes.append(BillableCode(billableCode:billableCodeObj["billableCodeName"] as? String,costPerHour: billableCodeObj["costPerHour"] as? Int))
                        }
                        vc.didFetchCode(data: billableCodes)
                    }
                }
            }
        }
        
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
    
        
    func getNonBillableCode(vc: nonCodeAcquiredDelegate) {
        let db = Firestore.firestore();
        var nonBillableCodes = [String]()
        let nonBillableCodeRef = db.collection("NonBillableCode")
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

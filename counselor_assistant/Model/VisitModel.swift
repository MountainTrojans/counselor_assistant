//
//  VisitModel.swift
//  counselor_assistant
//
//  Created by Yi Xu on 10/2/21.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

class VisitModel
{
    public var visits: Array<Visit> = Array<Visit>()
    static let shared = VisitModel();
    static let accountModel = AccountModel.sharedInstance
    
    let db = Firestore.firestore();
    let username: String = accountModel.gmail ?? "test";
    
    func loadExistingInfo() {
        let uploadedVideosRef = db.collection(username)
        uploadedVideosRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let actualquery = querySnapshot
                {
                    if !actualquery.isEmpty
                    {
                        self.visits.removeAll()
                        for document in querySnapshot!.documents {
                            let visitObj = document.data() as? [String: AnyObject]
                            
                            self.visits.append(Visit(billableCodeSelection: visitObj?["billableCodeSelection"] as? Int, programSelection: visitObj?["programSelection"] as? Int, nonBillableCodeSelection: visitObj?["nonBillableCodeSelection"] as? Int, totalRoundTripMiles: visitObj?["totalRoundTripMiles"] as? Double, totalRoundTripMinutes: visitObj?["totalRoundTripMinutes"] as? Double, serviceMinutes: visitObj?["serviceMinutes"] as? Double, documentationMinutes: visitObj?["documentationMinutes"] as? Double, noteWritten: visitObj?["noteWritten"] as? Bool, noteApproved: visitObj?["noteApproved"] as? Bool, CDI: visitObj?["CDI"] as? Bool))
                            print(self.visits)
                        }
                    }
                }
            }
        }
    }
    
    func addNewVisit(visit: Visit) {
        visits.append(visit)
        let randomID = UUID.init().uuidString
        db.collection("VisitHistory_"+username).document(randomID).setData([
            "billableCodeSelection": visit.billableCodeSelection,
            "programSelection":visit.programSelection,
            "nonBillableCodeSelection":visit.nonBillableCodeSelection,
            "totalRoundTripMiles":visit.totalRoundTripMiles,
            "totalRoundTripMinutes":visit.totalRoundTripMinutes,
            "serviceMinutes": visit.serviceMinutes,
            "documentationMinutes": visit.documentationMinutes,
            "noteWritten" : visit.noteWritten,
            "noteApproved" : visit.noteApproved,
            "CDI": visit.CDI,
            "uid": randomID,
        ]) { (error) in
                if error != nil
                {
                
                }
            }
    }
    

    
    func addNewProgram(name: String){
        let randomID = UUID.init().uuidString
        db.collection("Program").document(randomID).setData([
            "programName": name
        ]) { (error) in
                if error != nil{
                    print("Error in AddNewNonBillableCode")
                }
            }
    }
        
    func loadProgram() -> [String] {
        var program = [String]()
        let programRef = db.collection("Program")
        programRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let actualquery = querySnapshot{
                    if !actualquery.isEmpty{
                        for document in querySnapshot!.documents {
                            let programObj = document.data() as? [String: AnyObject]
                            let name = programObj?["programName"]
                            program.append(name as! String)
                        }
                    }
                }
            }
        }
        return program
    }
    
    func addNewAdmin(email: String){
        let randomID = UUID.init().uuidString
        db.collection("Admin").document(randomID).setData([
            "adminEmail": email
        ]) { (error) in
                if error != nil{
                    print("Error in AddNewNonBillableCode")
                }
            }
    }
        
    func isAdmin() -> Bool {
        var admin = [String]()
        let adminRef = db.collection("Admin")
        adminRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let actualquery = querySnapshot{
                    if !actualquery.isEmpty{
                        for document in querySnapshot!.documents {
                            let adminObj = document.data() as? [String: AnyObject]
                            let email = adminObj?["adminEmail"]
                            admin.append(email as! String)
                        }
                    }
                }
            }
        }
        return admin.contains(username)
    }

    
}

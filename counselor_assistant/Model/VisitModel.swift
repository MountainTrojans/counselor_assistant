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
        print("Made it to the add new" + username)
        visits.append(visit)
        let randomID = UUID.init().uuidString
        db.collection("VisitHistory_"+username).document(randomID).setData([
            "clientInitials":visit.clientInitials,
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
    
        

    
}

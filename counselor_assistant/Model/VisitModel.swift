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

protocol visitsAcquiredDelegate {
    func didFetchVisits(data: [Visit]);
    func didEditVisits();
    func didRemoveVisits();
}


class VisitModel
{
    
    static let shared = VisitModel()
    static let accountModel = AccountModel.sharedInstance
    
    static let db = Firestore.firestore()
    static let username: String = accountModel.gmail ?? "noEmail"
    
    static func loadExistingInfo(vc: visitsAcquiredDelegate, email: String) {
        var visits = Array<Visit>();
       
//        print("VisitHistory_"+username)
//        let uploadedVideosRef = db.collection("VisitHistory_"+username)
        let uploadedVideosRef = db.collection("VisitHistory_"+email)
        uploadedVideosRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let actualquery = querySnapshot
                {
                    if !actualquery.isEmpty
                    {
                        print("The list is not empty")
                        for document in querySnapshot!.documents {
                            let visitObj = document.data() as [String: AnyObject]
                            visits.append(
                                Visit(
                                    clientInitials: visitObj["clientInitials"] as? String,
                                    billableCodeSelection: visitObj["billableCodeSelection"] as? String,
                                    programSelection: visitObj["programSelection"] as? String,
                                    nonBillableCodeSelection: visitObj["nonBillableCodeSelection"] as? String,
                                    totalRoundTripMiles: visitObj["totalRoundTripMiles"] as? Double,
                                    totalRoundTripMinutes: visitObj["totalRoundTripMinutes"] as? Double,
                                    serviceMinutes: visitObj["serviceMinutes"] as? Double,
                                    documentationMinutes: visitObj["documentationMinutes"] as? Double,
                                    noteWritten: visitObj["noteWritten"] as? Bool,
                                    noteApproved: visitObj["noteApproved"] as? Bool,
                                    CDI: visitObj["CDI"] as? Bool,
                                    notes: visitObj["notes"] as? String,
                                    date: visitObj["date"] as? String,
                                    randomID: document.documentID,
                                    counselor : visitObj["counselor"] as? String))
                                
                        }
                    }
                    vc.didFetchVisits(data: visits);
                }
            }
        }
    }
    
    func addNewVisit(visit: Visit, vc: visitsAcquiredDelegate) {
        // db.collection("Account")
        VisitModel.db.collection("VisitHistory_"+VisitModel.username).document(visit.randomID).setData([
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
            "notes" : visit.notes,
            "CDI": visit.CDI,
            "date": visit.date,"counselor": visit.counselor, "visitId" : visit.randomID
        ]) { (error) in
                if error != nil
                {
                    print("Error in addNewVisit")
                } else {
                    vc.didEditVisits()
                }
            }
    }
    
    static func deleteVisit(visit: Visit, vc: visitsAcquiredDelegate) {
        db.collection("VisitHistory_"+VisitModel.username).document(visit.randomID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                vc.didRemoveVisits()
            }
        }
    }
    

    
}

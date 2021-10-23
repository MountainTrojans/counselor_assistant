//
//  ProgramModel.swift
//  counselor_assistant
//
//  Created by Yi Xu on 10/22/21.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol programAcquiredDelegate {
    func didFetchPrograms(data: [Program]);
    func didEditPrograms();
    func didRemovePrograms()
}


class ProgramModel {
    static let db = Firestore.firestore();
    
    static func setNewProgram(program: Program, vc: programAcquiredDelegate){
        
        BillableCodeModel.db.collection("Program").document(program.randomID).setData([
            "programName": program.programName,"programTotal":program.programTotal, "moneyLeft": program.moneyLeft, "description": program.description
        ]) { (error) in
                if error != nil{
                    print("Error in AddNewProgram")
                } else {
                    vc.didEditPrograms()
                }
            }
    }
    
    static func deleteProgram(program: Program, vc: programAcquiredDelegate) {
        db.collection("Program").document(program.randomID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                vc.didRemovePrograms()
            }
        }
    }
    
    
        
    static func getPrograms(vc: programAcquiredDelegate) {
        var programs = [Program]()
        let programRef = ProgramModel.db.collection("Program")
        programRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let actualquery = querySnapshot{
                    if !actualquery.isEmpty{
                        for document in querySnapshot!.documents {
                            let programObj = document.data() as [String: AnyObject]
                            programs.append(Program(programName: programObj["programName"] as? String, programTotal: programObj["programTotal"] as? Double, moneyLeft: programObj["moneyLeft"] as? Double, description: programObj["description"] as? String, randomID: document.documentID))
                        }
                        vc.didFetchPrograms(data: programs)
                    }
                }
            }
        }
        
    }
    

    
}

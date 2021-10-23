//
//  newVisitController.swift
//  counselor_assistant
//
//  Created by Tyler Rosselli on 10/14/21.
//

import UIKit
class NewVisitController: UIViewController, codeAcquiredDelegate, visitsAcquiredDelegate {
    func didFetchVisits(data: [Visit]) {
        
    }
    func didEditVisits() {
        
    }
    func didRemoveVisits() {
        
    }
    
    func didEditCode() {
        return
    }
    
    func didRemoveCode() {
        return
    }
    
    
    func didFetchCode(data: [BillableCode]) {
        // do something with data
        
    }
    func didFetchCode(data: [String]) {
        // do something with data
    }
 
    override func viewDidLoad() {
        BillableCodeModel.getBillableCode(vc: self)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var clientInitials: UITextField!
    @IBOutlet weak var billableCode: UITextField!
    @IBOutlet weak var programSelection: UITextField!
    @IBOutlet weak var nonBillableCodeSelection: UITextField!
    @IBOutlet weak var totalRoundTripMiles: UITextField!
    @IBOutlet weak var roundTripMinutes: UITextField!
    @IBOutlet weak var serviceMinutes: UITextField!
    @IBOutlet weak var documentationMinutes: UITextField!
    @IBOutlet weak var noteWritten: UITextField!
    @IBOutlet weak var noteApproved: UITextField!
    @IBOutlet weak var CDI: UITextField!
    
    @IBAction func submitVisitTapped(_ sender: UIButton) {
        let client: String? = String(clientInitials.text!)
        let addbillableCode: Int? = Int(billableCode.text!)
        let nonBillableCode: Int? = Int(nonBillableCodeSelection.text!)
        let program : Int? = Int(programSelection.text!)
        let addmiles :Double? = Double(totalRoundTripMiles.text!)
        let tripminutes: Double? = Double(roundTripMinutes.text!)
        let addserviceMinutes:Double? = Double(serviceMinutes.text!)
        let documentMinutes:Double? = Double(documentationMinutes.text!)
        let notewritten:Bool? = Bool(noteWritten.text!)
        let noteapproved: Bool? = Bool(noteApproved.text!)
        let cdi:Bool? = Bool(CDI.text!)



        let visit = Visit(clientInitials:client,billableCodeSelection: addbillableCode,programSelection: program,nonBillableCodeSelection: nonBillableCode,totalRoundTripMiles: addmiles,totalRoundTripMinutes: tripminutes,serviceMinutes: addserviceMinutes,documentationMinutes: documentMinutes,noteWritten: notewritten,noteApproved: noteapproved,CDI: cdi)
        VisitModel.shared.addNewVisit(visit: visit, vc: self)
        self.navigationController?.popViewController(animated: true)


    }
}

//
//  newVisitController.swift
//  counselor_assistant
//
//  Created by Tyler Rosselli on 10/14/21.
//

import UIKit
class NewVisitController: UIViewController, BillableCodeDelagate, visitsAcquiredDelegate ,
                           UIPickerViewDelegate, UIPickerViewDataSource{
    func didFetchVisits(data: [Visit]) {
        
    }
    func didEditVisits() {
        
    }
    func didRemoveVisits() {
        
    }
    
    func didEditBillableCode() {
        return
    }
    
    func didRemoveBillableCodeCode() {
        return
    }
    
    
    func didFetchBillableCode(data: [BillableCode]) {
        // do something with data
        BillableCodeArray = data
        
    }
    func didFetchCode(data: [String]) {
        // do something with data
    }
 
    override func viewDidLoad() {
        BillableCodeModel.getBillableCode(vc: self)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBOutlet weak var billCodeBtn: UIButton!
    
    
    @IBOutlet weak var clientInitials: UITextField!

    @IBOutlet weak var programSelection: UIButton!
    @IBOutlet weak var nonBillableCodeSelection: UIButton!
    @IBOutlet weak var totalRoundTripMiles: UITextField!
    @IBOutlet weak var roundTripMinutes: UITextField!
    @IBOutlet weak var serviceMinutes: UITextField!
    @IBOutlet weak var documentationMinutes: UITextField!
    @IBOutlet weak var noteWritten: UISwitch!
    @IBOutlet weak var noteApproved: UISwitch!
    @IBOutlet weak var CDI: UISwitch!
    @IBOutlet weak var Notes: UITextField!
    
    @IBAction func submitVisitTapped(_ sender: UIButton) {
//        let client: String? = String(clientInitials.text!)
//        let addbillableCode: Int? = Int(billableCode.text!)
//        let nonBillableCode: Int? = Int(nonBillableCodeSelection.text!)
//        let program : Int? = Int(programSelection.text!)
//        let addmiles :Double? = Double(totalRoundTripMiles.text!)
//        let tripminutes: Double? = Double(roundTripMinutes.text!)
//        let addserviceMinutes:Double? = Double(serviceMinutes.text!)
//        let documentMinutes:Double? = Double(documentationMinutes.text!)
//        let notewritten:Bool? = Bool(noteWritten.text!)
//        let noteapproved: Bool? = Bool(noteApproved.text!)
//        let cdi:Bool? = Bool(CDI.text!)
//
//
//
//        let visit = Visit(clientInitials:client,billableCodeSelection: addbillableCode,programSelection: program,nonBillableCodeSelection: nonBillableCode,totalRoundTripMiles: addmiles,totalRoundTripMinutes: tripminutes,serviceMinutes: addserviceMinutes,documentationMinutes: documentMinutes,noteWritten: notewritten,noteApproved: noteapproved,CDI: cdi)
//        VisitModel.shared.addNewVisit(visit: visit, vc: self)
//        self.navigationController?.popViewController(animated: true)


    }
    
    
    
    
    let screenWidth = UIScreen.main.bounds.width - 10
        let screenHeight = UIScreen.main.bounds.height / 2
        var selectedRow = 0
        //var selectedRowTextColor = 0
        
    var BillableCodeArray: [BillableCode] = []
        
    @IBAction func popUpPicker(_ sender: UIButton)
    {
        
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:screenHeight))

            pickerView.dataSource = self
            pickerView.delegate = self
            
            pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            //pickerView.selectRow(selectedRowTextColor, inComponent: 1, animated: false)
            
            vc.view.addSubview(pickerView)
            pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
            pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        
        
        if(sender == billCodeBtn){
            pickerView.tag = 1
            
            
            let alert = UIAlertController(title: "Select Background Colour", message: "", preferredStyle: .actionSheet)
            
            alert.setValue(vc, forKey: "contentViewController")
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            }))
            
            alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
//                self.selectedRow = pickerView.selectedRow(inComponent: 0)
//                //self.selectedRowTextColor = pickerView.selectedRow(inComponent: 1)
//                let selected = Array(self.backGroundColours)[self.selectedRow]
//                //let selectedTextColor = Array(self.backGroundColours)[self.selectedRowTextColor]
//                let colour = selected.value
//                let name = selected.key
//                self.view.backgroundColor = colour
//                self.pickerViewButton.setTitle(name, for: .normal)
//                //self.pickerViewButton.setTitleColor(selectedTextColor.value, for: .normal)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
            
           
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            
            if(pickerView.tag == 1 ){
                return BillableCodeArray[row].billableCode ?? ""
            } else if(pickerView.tag == 2){
                
            }
            
            return ""
            
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int
        {
            return 1 //return 2
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
        {
            if(pickerView.tag == 1 ){
                BillableCodeArray.count
            }
            
            return 0;
        }
        
       
}

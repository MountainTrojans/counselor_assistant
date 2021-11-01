import UIKit

class detailedInformationViewController: UIViewController,BillableCodeDelagate {
    func didFetchBillableCode(data: [BillableCode]) {
    }
    
    func didEditBillableCode() {
        let alert = UIAlertController(title:"You have successfully edited this Billable code",message:"You can now view the new billable code", preferredStyle: .alert )
        alert.addAction(UIAlertAction(title:"Okay", style:.default,handler: { action in
           
        }))

        self.present(alert,animated:true)

    }
    
    func didRemoveBillableCodeCode() {
    
    }
    
    
    var billableCode : BillableCode = BillableCode()
    
    @IBOutlet weak var codePrice: UITextField!
    @IBOutlet weak var codeName: UITextField!
    @IBOutlet weak var codeDescription: UITextField!
    
    @IBOutlet weak var submitEdits: UIButton!
    @IBOutlet weak var editCode: UIButton!
    var oldName = ""
    var oldDescription = ""
    


    override func viewDidLoad() {
        super.viewDidLoad()
        print(AccountModel.sharedInstance.isAdmin)
        if(!AccountModel.sharedInstance.isAdmin){
            editCode.isHidden = true
        }
        submitEdits.isHidden = true
        codeDescription.isUserInteractionEnabled = false
        codePrice.isUserInteractionEnabled = false
        codeName.isUserInteractionEnabled = false
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        
        codeDescription.isUserInteractionEnabled = true
        codePrice.isUserInteractionEnabled = true
        codeName.isUserInteractionEnabled = true
        submitEdits.isHidden = false
    }
    

    @IBAction func didSubmitEdits(_ sender: Any) {
        BillableCodeModel.deleteBillableCode(billableCode: billableCode, vc: self)
        let billabled: BillableCode = BillableCode()
        billabled.billableCode = codeName.text
        billabled.costPerHour = Int(codePrice.text!)
        billabled.description = codeDescription.text
        
      
        BillableCodeModel.addNewBillableCode(  billableCode: billabled, vc: self)
        _ = navigationController?.popViewController(animated: true)
    }
 
}

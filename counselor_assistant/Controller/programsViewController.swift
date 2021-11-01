import UIKit

class programsViewController: UIViewController,programAcquiredDelegate {
    func didFetchPrograms(data: [Program]) {
        
    }
    
    func didEditPrograms() {
        let alert = UIAlertController(title:"You have successfully edited this Program code",message:"You can now view the new program Code", preferredStyle: .alert )
        alert.addAction(UIAlertAction(title:"Okay", style:.default,handler: { action in
            
        }))

        self.present(alert,animated:true)
    }
    
    func didRemovePrograms() {
        
    }
    
    
    

    @IBOutlet weak var programName: UITextField!
    @IBOutlet weak var totalMoney: UITextField!
    @IBOutlet weak var moneyLeft: UITextField!
    @IBOutlet weak var editCode: UIButton!
    @IBOutlet weak var programDescription: UITextField!
    @IBOutlet weak var submitEdits: UIButton!
    var program : Program  = Program()
    var oldName = ""
    var oldDescription = ""
    


    override func viewDidLoad() {
        super.viewDidLoad()
        if(!AccountModel.sharedInstance.isAdmin){
            editCode.isHidden = true
        }
        submitEdits.isHidden = true
        programDescription.isUserInteractionEnabled = false
        totalMoney.isUserInteractionEnabled = false
        moneyLeft.isUserInteractionEnabled = false
        programName.isUserInteractionEnabled = false
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        
        programDescription.isUserInteractionEnabled = true
        totalMoney.isUserInteractionEnabled = true
        programName.isUserInteractionEnabled = true
        submitEdits.isHidden = false
    }
    

    @IBAction func didSubmitEdits(_ sender: Any) {
        let newProgram: Program = Program()
        newProgram.programName = programName.text
        newProgram.programTotal = Double(totalMoney.text!)
        newProgram.description = programDescription.text
        var moneySpent = -1.0
        if(program.programTotal != nil){
            moneySpent = program.programTotal! - program.moneyLeft!
        }
        else{
            moneySpent = 0
        }
        
        let newMoneyLeft = newProgram.programTotal! - moneySpent
        newProgram.moneyLeft = newMoneyLeft
        ProgramModel.deleteProgram(program: program, vc: self)
        ProgramModel.setNewProgram(program: newProgram, vc: self)
      
    }
 
}

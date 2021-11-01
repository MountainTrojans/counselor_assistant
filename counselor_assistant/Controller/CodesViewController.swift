import UIKit

class CodesViewController: UITableViewController, BillableCodeDelagate {
    func didRemoveBillableCodeCode() {
        return
    }
    
    func didEditBillableCode() {
        return
    }
    
    func didRemoveCode() {
        
    }
    
    var billableCodes = Array<BillableCode>()
    func didFetchBillableCode(data: [BillableCode]) {
        print("Fetched Code")
        billableCodes = Array<BillableCode>(data)
       
        tableView.reloadData()
    }
    let controller_function:String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        BillableCodeModel.getBillableCode(vc: self)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           tableView.reloadData()
       }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count " + String(billableCodes.count))
        return billableCodes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :codesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "codeCell") as! codesTableViewCell
        let billableCode = billableCodes[indexPath.row]
        print(billableCode.billableCode)
        cell.billableCodeLabel.text = billableCode.billableCode ?? nil
        return cell
    }
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath){
        let selectedBillableCode = billableCodes[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let  destinationVC = storyboard.instantiateViewController(withIdentifier: "detailedInformation") as! detailedInformationViewController
        destinationVC.loadViewIfNeeded()
        destinationVC.codeDescription.text = selectedBillableCode.description
        let number : Int = selectedBillableCode.costPerHour ?? -1
        let xNSNumber = number as NSNumber
        let xString : String = xNSNumber.stringValue
        destinationVC.codePrice.text = xString
        destinationVC.billableCode = selectedBillableCode
        destinationVC.codeName.text = selectedBillableCode.billableCode
        print("Code Name" + destinationVC.codeName.text!)
        print( destinationVC.codeDescription.text!)
        self.present(destinationVC, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       let footerView = UIView()
        //   footerView.backgroundColor =
       footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:
       100)
       let button = UIButton()
       button.frame = CGRect(x: 20, y: 10, width: 300, height: 50)
       button.setTitle("Add New Billable Code", for: .normal)
        button.backgroundColor = UIColor.blue
        if(AccountModel.sharedInstance.isAdmin){
            footerView.addSubview(button)
        }
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
       return footerView
    }
    @objc func pressed() {
        let  destinationVC = storyboard?.instantiateViewController(withIdentifier: "detailedInformation") as! detailedInformationViewController
        destinationVC.loadViewIfNeeded()
        destinationVC.codeDescription.placeholder = "Put in your Description here"
        destinationVC.codePrice.placeholder = "billable code price"
        destinationVC.codeName.placeholder = "Billable Code Name"
        if(AccountModel.sharedInstance.isAdmin){
            self.present(destinationVC, animated: true, completion: nil)
        }
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

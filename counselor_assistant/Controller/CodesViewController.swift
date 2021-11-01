//
//  CodesViewController.swift
//  counselor_assistant
//
//  Created by Tyler Rosselli on 10/22/21.
//

import UIKit

class CodesViewController: UITableViewController, BillableCodeDelagate {
    func didRemoveBillableCodeCode() {
        return
    }
    
    func didEditBillableCode() {
        return
    }
    
    
    var billableCodes = Array<BillableCode>()
    func didFetchBillableCode(data: [BillableCode]) {
        print("Fetched Code")
        billableCodes = Array<BillableCode>(data)
        print("Count after Fetching" + String(billableCodes.count))
        tableView.reloadData()
    }


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
        return cell
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

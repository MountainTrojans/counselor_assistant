//
//  programsTableViewController.swift
//  counselor_assistant
//
//  Created by Tyler Rosselli on 10/31/21.
//

import UIKit
class programsTableViewController: UITableViewController, programAcquiredDelegate{
    var programs = Array<Program>()
    func didFetchPrograms(data: [Program]) {
        programs = Array<Program>(data)
        tableView.reloadData()
    }
    
    func didEditPrograms() {
        
    }
    
    func didRemovePrograms() {
        
    }
    
   
    let controller_function:String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        print("about to get codes")
        ProgramModel.getPrograms(vc: self)
        print("got codes")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           tableView.reloadData()
       }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :programsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "programCodeCell") as! programsTableViewCell
        let program = programs[indexPath.row]
        cell.programLable.text = program.programName ?? nil
        return cell
    }
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath){
        let selectedProgram = programs[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let  destinationVC = storyboard.instantiateViewController(withIdentifier: "programsInformation") as! programsViewController
        destinationVC.loadViewIfNeeded()
        destinationVC.program = programs[indexPath.row]
        destinationVC.programName.text = selectedProgram.programName
        destinationVC.programDescription.text = selectedProgram.description
        
        
        
        let pTotalMoney : Double = selectedProgram.programTotal ?? -1
        let xNSTotalMoney = pTotalMoney as NSNumber
        let xString : String = xNSTotalMoney.stringValue
        destinationVC.totalMoney.text = xString
        
        let totalMoneyLeft : Double = selectedProgram.moneyLeft ?? -1
        let xNSTotalMoneyLeft = totalMoneyLeft as NSNumber
        let moneyLeftString : String = xNSTotalMoneyLeft.stringValue
        destinationVC.moneyLeft.text = moneyLeftString
        self.present(destinationVC, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       let footerView = UIView()
        //   footerView.backgroundColor =
       footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:
       100)
       let button = UIButton()
       button.frame = CGRect(x: 20, y: 10, width: 300, height: 50)
       button.setTitle("Add New Program Code", for: .normal)
        button.backgroundColor = UIColor.blue
        if(AccountModel.sharedInstance.isAdmin){
            footerView.addSubview(button)
        }
        
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
       return footerView
    }
    @objc func pressed() {
        let  destinationVC = storyboard?.instantiateViewController(withIdentifier: "programsInformation") as! programsViewController
        destinationVC.loadViewIfNeeded()
        destinationVC.totalMoney.placeholder = "How Much Total Money will be available?"
        destinationVC.programName.placeholder = "Program Name"
        destinationVC.programDescription.placeholder = "Program Description"
        destinationVC.moneyLeft.placeholder = "Funds available to this program will show here"
        destinationVC.programName.isUserInteractionEnabled = true
        destinationVC.programDescription.isUserInteractionEnabled = true
        destinationVC.totalMoney.isUserInteractionEnabled = true
        destinationVC.editCode.isHidden = true
        destinationVC.submitEdits.isHidden = false
        if(AccountModel.sharedInstance.isAdmin){
            self.present(destinationVC, animated: true, completion: nil)
        }
        
    }
}

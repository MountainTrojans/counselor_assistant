//
//  VisitViewController.swift
//  counselor_assistant
//
//  Created by Zhenghao Dai on 10/19/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class VisitTableViewController: UITableViewController, visitsAcquiredDelegate,
                                UserDelagate, UIPickerViewDelegate, UIPickerViewDataSource {
    func didEditVisits() {
        return
    }
    
    func didRemoveVisits() {
        return
    }
    
    func didFetchVisits(data: [Visit]) {
        visits = Array<Visit>(data);
        tableView.reloadData()
        //self.visitTableViews.reloadData();
    }
    
    
    
    @IBOutlet weak var switchBtn: UIBarButtonItem!
    var visits = Array<Visit>();
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
            VisitModel.loadExistingInfo(vc: self, email: AccountModel.sharedInstance.gmail!)
            UserModel.getUser(vc: self)
           tableView.reloadData()
        
            switchBtn.customView?.isHidden = !AccountModel.sharedInstance.isAdmin
        
       }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Shared Count" + String(visits.count))
        return visits.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitCell") as! VisitTableViewCell
        let visit = visits[indexPath.row]
        print("Credentials:" + visit.clientInitials!)
        cell.initials.text = visit.clientInitials
        cell.date.text = visit.notes
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           print("switch")
           //if tapped , then go to display all sessions
           if let newVisitcon = segue.destination as? NewVisitController{
                if let selectedIndex = tableView.indexPathForSelectedRow?.row{
                    print("selecting" + String(selectedIndex))
               
                   if let identity = segue.identifier{
                       if identity == "ClickView"{
                           newVisitcon.submitButton.customView?.isHidden = true
                           
                           newVisitcon.clientInitialsText = visits[selectedIndex].clientInitials ?? ""
                           newVisitcon.totalRoundTripMilestextText = visits[selectedIndex].totalRoundTripMiles ?? 0
                           newVisitcon.roundTripMinutesText = visits[selectedIndex].totalRoundTripMinutes ?? 0
                           newVisitcon.serviceMinutesText = visits[selectedIndex].serviceMinutes ?? 0
                           newVisitcon.documentationMinutesText = visits[selectedIndex].documentationMinutes ?? 0
                           newVisitcon.NotesText = visits[selectedIndex].clientInitials ?? ""
                           
                           
                       }
                   }
                }
           }
        
    }
    
    
    var users = [String]()
    func didFetchUser(data: [String]) {
        users = data
        tableView.reloadData()
    }
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
//    var users: [String] = ["Admin", "Staff", "1", "2" ,"3"]

    @IBAction func popUpPicker(_ sender: UIButton)
    {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:screenHeight))

        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true

        pickerView.tag = 1
        
        let alert = UIAlertController(title: "Choose a Member to view their VisitHistory.", message: "", preferredStyle: .actionSheet)
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in }))
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selected = self.users[self.selectedRow]
            VisitModel.loadExistingInfo(vc: self, email: selected)
        }))
        self.present(alert, animated: true, completion: nil)
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return users[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        users.count
    }
    
}

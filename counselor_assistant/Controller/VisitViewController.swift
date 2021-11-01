//
//  VisitViewController.swift
//  counselor_assistant
//
//  Created by Zhenghao Dai on 10/19/21.
//

import UIKit

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
    
    
    //@IBOutlet weak var visitTableViews: UITableView!
    
    var visits = Array<Visit>();
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.register(UINib(nibName: "AccountsTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
//        visitTableViews.delegate = self
//        visitTableViews.dataSource = self
        
        VisitModel.loadExistingInfo(vc: self)
        UserModel.getUser(vc: self)
        
      //  VisitModel.shared.loadExistingInfo()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           tableView.reloadData()
       }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Shared Count" + String(visits.count))
        return visits.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitCell") as! VisitTableViewCell
        let visit = visits[indexPath.row]
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

//
//  VisitViewController.swift
//  counselor_assistant
//
//  Created by Zhenghao Dai on 10/19/21.
//

import UIKit

class VisitTableViewController: UITableViewController, visitsAcquiredDelegate {
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
        //cell.labelView.text = visit.clientInitials ?? nil
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

}

//extension VisitViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//
//        print("Shared Count" + String(visits.count))
//        return visits.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = visitTableViews.dequeueReusableCell(withIdentifier: "visitCell") as! VisitTableViewCell
//        let visit = visits[indexPath.row]
//        cell.labelView.text = visit.clientInitials ?? nil
//        return cell
//    }
//}

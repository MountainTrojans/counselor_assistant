//
//  VisitViewController.swift
//  counselor_assistant
//
//  Created by Albert on 2021/10/15.
//

import UIKit

class VisitViewController: UIViewController {

    @IBOutlet weak var visitTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitTableView.dataSource = self
        // Do any additional setup after loading the view.
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

extension VisitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        VisitModel.shared.loadExistingInfo()
        return VisitModel.shared.visits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = visitTableView.dequeueReusableCell(withIdentifier: "visitCell") as!
 VisitTableViewCell
        let visit = VisitModel.shared.visits[indexPath.row]
        cell.visitLbl.text = visit.clientInitials ?? nil
        return cell
    }
}

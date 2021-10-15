//
//  VisitViewController.swift
//  counselor_assistant
//
//  Created by Albert on 2021/10/15.
//

import UIKit

class VisitViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var visitTableViews: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.register(UINib(nibName: "AccountsTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        visitTableViews.delegate = self
        visitTableViews.dataSource = self
      //  VisitModel.shared.loadExistingInfo()
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
        print("Shared Count" + String(VisitModel.shared.visits.count))
        return VisitModel.shared.visits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = visitTableViews.dequeueReusableCell(withIdentifier: "visitCell") as! VisitTableViewCell
        let visit = VisitModel.shared.visits[indexPath.row]
        cell.labelView.text = visit.clientInitials ?? nil
        return cell
    }
}

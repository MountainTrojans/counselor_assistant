//
//  AnalyticsViewController.swift
//  counselor_assistant
//
//  Created by Albert on 2021/11/12.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class AnalyticsViewController: UIViewController, visitsAcquiredDelegate {
    
    @IBOutlet weak var TotalTimeLbl: UILabel!
    @IBOutlet weak var CurrentMonthLbl: UILabel!
    
    var visits = Array<Visit>()
    
    func didFetchVisits(data: [Visit]) {
        
        visits = Array<Visit>(data)
        var TotalRoundTripMiles: Double = 0
        var totalTime: Double = 0
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        let currentDate = formatter1.string(from: today)
        let currentMonth = currentDate.split(separator: "/")[0]
        
        for visit in visits {
            if (visit.date == nil) {
                continue
            }
            if let month = visit.date?.split(separator: "/")[0] {
                if (month == currentMonth) {
                    totalTime += (visit.totalRoundTripMinutes ?? 0.0) + (visit.serviceMinutes ?? 0.0) + (visit.documentationMinutes ?? 0.0)
                }
            }
        }
        TotalTimeLbl.text = String(totalTime)
        CurrentMonthLbl.text = String(currentMonth)
    
    }
    func didEditVisits() {
        return
    }
    func didRemoveVisits() {
        return
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        VisitModel.loadExistingInfo(vc: self, email: VisitModel.username)
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

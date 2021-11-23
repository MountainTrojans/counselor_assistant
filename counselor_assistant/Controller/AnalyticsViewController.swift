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

class AnalyticsViewController: UIViewController, visitsAcquiredDelegate, UserDelagate {
    func didFetchUser(data: [String]) {
        var numVisits = 0
        users = Array<String>(data)
        for curUser in users {
            print(curUser + "Found user")
            VisitModel.loadExistingInfo(vc: self,email: curUser )
            
        }

        
        
        
    }
    

    var users = Array<String>()
    @IBAction func generateCSV(_ sender: Any) {

        let sfileName = "test.csv"
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let documentURL = URL(fileURLWithPath: documentDirectoryPath).appendingPathComponent(sfileName)
        let output = OutputStream.toMemory()
        let csvWriter = CHCSVWriter(outputStream: output, encoding: String.Encoding.utf8.rawValue, delimiter: ",".utf16.first!)
        csvWriter?.writeField("Counselor")
        csvWriter?.writeField("Visit_Initials")
        csvWriter?.writeField("Visit Total Miles")
        csvWriter?.writeField("Visit travel time")
        csvWriter?.writeField("Billable Code")
        csvWriter?.writeField("Date")

        csvWriter?.finishLine()

        var totalMiles = 0.0
        for visit in allVisits{
            csvWriter?.writeField(visit.counselor ?? "No Counselor Specified")
            csvWriter?.writeField(visit.clientInitials ?? "no initials provided")
            csvWriter?.writeField(visit.totalRoundTripMiles ?? "0.0")
            totalMiles = totalMiles + Double(visit.totalRoundTripMiles ?? 0.0)
            csvWriter?.writeField(visit.totalRoundTripMinutes ?? "no minutes provided")
            csvWriter?.writeField(visit.billableCodeSelection ?? "no billable code selected")
            csvWriter?.writeField(visit.date ?? "no date known")
            csvWriter?.finishLine()
        }
        csvWriter?.closeStream()
        let buffer = (output.property(forKey: .dataWrittenToMemoryStreamKey) as? Data)!
        do {
            print(documentDirectoryPath)
            try buffer.write(to:documentURL);print("success")
        }
        catch{}
        let alert = UIAlertController(title: "You have Saved a copy of the CSV File", message: "To find the file, Navigate to the files app on your iphone and select the browse tab on the bottom right. Then select \"On My iPhone\".", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
    }


    @IBOutlet weak var indvTotalHoursLbl: UILabel!
    @IBOutlet weak var indvWorkDayHourslbl: UILabel!
    @IBOutlet weak var indvProductivityLbl: UILabel!
    @IBOutlet weak var indvCurrentMonthLbl: UILabel!
    
    
    
    
    @IBOutlet weak var productivityLbl: UILabel!
    @IBOutlet weak var totalWorkHours: UILabel!
    @IBOutlet weak var CurrentMonthLbl: UILabel!
    @IBOutlet weak var TotalTimeLbl: UILabel!
    var visits = Array<Visit>()
    var allVisits = Array<Visit>()

  
    var totalDaysWorked = 0
    var totalTime: Double = 0
    var indvTotalTime: Double = 0
    var employees = Set<String>()
    var visitIds = Set<String>()
    var indvTotalDaysWorked = 0
    func didFetchVisits(data: [Visit]) {
        visits = Array<Visit>(data)
        var TotalRoundTripMiles: Double = 0

        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        let currentDate = formatter1.string(from: today)
        print(currentDate)
        let currentMonth = currentDate.split(separator: "/")[0]
        CurrentMonthLbl.text = String(currentMonth)
        indvCurrentMonthLbl.text = String(currentMonth)
        var indvDays = Set<String>()
        
        for visit in visits {
            allVisits.append(visit)
            if (visit.date == nil) {
                continue
            }
            
            print(visit.counselor)
            //only keep the data from the past year
            let month = visit.date?.split(separator: "/")[0] ?? ""
            let day = visit.date?.split(separator: "/")[1] ?? ""
            var addTime = (visit.totalRoundTripMinutes ?? 0.0) + (visit.serviceMinutes ?? 0.0) + (visit.documentationMinutes ?? 0.0)
            if (month == currentMonth && !visitIds.contains(visit.visitId ?? "")) {
                print("inside first if")
                if !indvDays.contains(String(day)){
                    print("inside second")
                    print(String(day))
                    indvDays.insert(String(day))
                    totalDaysWorked+=1
                    if(visit.counselor == AccountModel.sharedInstance.gmail){
                        indvTotalDaysWorked += 1
                    }
                            
                }
                if(visit.counselor == AccountModel.sharedInstance.gmail){
                    indvTotalTime += addTime
                    
                }

                visitIds.insert(visit.visitId ?? "")
                totalTime += addTime
               

            }
            
        }
        print("made it here")
        let totalHoursWorked = totalTime/60
        let totalTimeWorked = Double(8*totalDaysWorked)
        let productivity = totalHoursWorked/totalTimeWorked
        print(productivity)
        print("Total Hours Worked" + String(totalHoursWorked))
        totalWorkHours.text = String(format: "%.2f", totalTimeWorked)
        TotalTimeLbl.text = String(format: "%.2f", totalHoursWorked)
        productivityLbl.text = String(format: "%.2f", productivity)
        print(totalDaysWorked)
        
        let indvTotalWorkHours = Double(indvTotalDaysWorked)*8.0
        indvTotalHoursLbl.text = String(format: "%.2f", indvTotalWorkHours)
        indvWorkDayHourslbl.text = String(format: "%.2f", indvTotalTime/60.0)
        let indvProductivity = (indvTotalTime/60.0)/indvTotalWorkHours
        indvProductivityLbl.text = String(format: "%.2f", indvProductivity)
        
        
           
        
    
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
    
    override func viewWillAppear(_ animated: Bool){
        UserModel.getUser(vc: self)
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

//
//  BillableCode.swift
//  counselor_assistant
//
//  Created by Tyler Rosselli on 10/18/21.
//

import Foundation

class BillableCode {
    internal init(billableCode:String? = nil,costPerHour:Int? = nil){
        self.billableCode = billableCode
        self.costPerHour = costPerHour
        
    }
    var billableCode:String?
    var costPerHour: Int?
    
}
class Programs{
    internal init(programName:String? = nil, programTotal:Double? = nil,moneyLeft:Double? = nil){
        self.programTotal = programTotal
        self.moneyLeft = moneyLeft
        self.programName = programName
    }
    var programName:String?
    var programTotal:Double?
    var moneyLeft:Double?
    
}

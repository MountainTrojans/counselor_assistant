//
//  BillableCode.swift
//  counselor_assistant
//
//  Created by Tyler Rosselli on 10/18/21.
//

import Foundation

class BillableCode {
    internal init(billableCode:Int? = nil,costPerHour:Int? = nil){
        self.billableCode = billableCode
        self.costPerHour = costPerHour
    }
    var billableCode:Int?
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

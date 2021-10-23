//
//  BillableCode.swift
//  counselor_assistant
//
//  Created by Tyler Rosselli on 10/18/21.
//

import Foundation

class BillableCode {
    internal init(billableCode: String? = nil, costPerHour: Int? = nil, description: String? = nil, randomID: String = UUID.init().uuidString) {
        self.billableCode = billableCode
        self.costPerHour = costPerHour
        self.description = description
        self.randomID = randomID
    }
    
    var billableCode:String?
    var costPerHour: Int?
    var description: String?
    var randomID: String
}

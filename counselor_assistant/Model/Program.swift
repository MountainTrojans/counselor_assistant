//
//  Program.swift
//  counselor_assistant
//
//  Created by Yi Xu on 10/22/21.
//

import Foundation

class Program {
    internal init(programName: String? = nil, programTotal: Double? = nil, moneyLeft: Double? = nil, description: String? = nil, randomID: String = UUID.init().uuidString) {
        self.programName = programName
        self.programTotal = programTotal
        self.moneyLeft = moneyLeft
        self.description = description
        self.randomID = randomID
    }
    
    var programName:String?
    var programTotal:Double?
    var moneyLeft:Double?
    var description: String?
    var randomID: String
}

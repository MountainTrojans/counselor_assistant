//
//  VisitModel.swift
//  counselor_assistant
//
//  Created by Yi Xu on 10/2/21.
//

import Foundation

class Visit
{
    //need to add the client initials as a parameter to the internal init
    internal init( clientInitials: String? = nil,billableCodeSelection: Int? = nil, programSelection: Int? = nil, nonBillableCodeSelection: Int? = nil, totalRoundTripMiles: Double? = nil, totalRoundTripMinutes: Double? = nil, serviceMinutes: Double? = nil, documentationMinutes: Double? = nil, noteWritten: Bool? = nil, noteApproved: Bool? = nil, CDI: Bool? = nil) {
        self.clientInitials = clientInitials
        self.billableCodeSelection = billableCodeSelection
        self.programSelection = programSelection
        self.nonBillableCodeSelection = nonBillableCodeSelection
        self.totalRoundTripMiles = totalRoundTripMiles
        self.totalRoundTripMinutes = totalRoundTripMinutes
        self.serviceMinutes = serviceMinutes
        self.documentationMinutes = documentationMinutes
        self.noteWritten = noteWritten
        self.noteApproved = noteApproved
        self.CDI = CDI
    }
    var clientInitials: String?;
    var billableCodeSelection: Int?;
    var programSelection: Int?;
    var nonBillableCodeSelection: Int?;
    var totalRoundTripMiles: Double?;
    var totalRoundTripMinutes: Double?;
    var serviceMinutes: Double?;
    var documentationMinutes: Double?;
    var noteWritten: Bool?;
    var noteApproved: Bool?;
    var CDI: Bool?;
    
    
    

}

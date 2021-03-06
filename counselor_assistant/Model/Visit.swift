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
    internal init( clientInitials: String? = nil,billableCodeSelection: String? = nil, programSelection: String? = nil, nonBillableCodeSelection: String? = nil, totalRoundTripMiles: Double? = nil, totalRoundTripMinutes: Double? = nil, serviceMinutes: Double? = nil, documentationMinutes: Double? = nil, noteWritten: Bool? = nil, noteApproved: Bool? = nil, CDI: Bool? = nil, notes: String? = nil, date: String?, randomID: String = UUID.init().uuidString,counselor: String?) {
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
        self.notes = notes
        self.counselor = counselor
        self.randomID = randomID
        self.visitId = randomID
        if let date = date {
            self.date = date
        } else {
            self.date = "NO KNOWN DATE";
        }
    }
    var clientInitials: String?;
    var billableCodeSelection: String?;
    var programSelection: String?;
    var nonBillableCodeSelection: String?;
    var totalRoundTripMiles: Double?;
    var totalRoundTripMinutes: Double?;
    var serviceMinutes: Double?;
    var documentationMinutes: Double?;
    var noteWritten: Bool?;
    var noteApproved: Bool?;
    var CDI: Bool?;
    var notes: String?;
    var randomID: String;
    var date: String?;
    var counselor: String?;
    var visitId: String?;

}

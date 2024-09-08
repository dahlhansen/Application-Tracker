//
//  Application.swift
//  Application Tracker
//
//  Created by Frederik Dahl Hansen on 07/09/2024.
//

import Foundation



class Application {
    var company : String
    var titel : String
    var status : Status
    
    init(company: String, titel: String, status: Status) {
        self.company = company
        self.titel = titel
        self.status = status
    }
}

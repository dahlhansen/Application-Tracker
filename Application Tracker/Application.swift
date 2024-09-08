//
//  Application.swift
//  Application Tracker
//
//  Created by Frederik Dahl Hansen on 07/09/2024.
//

import Foundation


//reference: https://www.hackingwithswift.com/books/ios-swiftui/working-with-identifiable-items-in-swiftui

struct Application: Identifiable {
    let id = UUID()
    let company : String
    let titel : String
    let status : Status
    
}

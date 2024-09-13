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
    let title : String
    var status : Status
    let date : Date
    
}

class ApplicationManager: ObservableObject {
    @Published var applications: [Application] = []
    
    func addApplication(company: String, title: String, status: Status, date: Date) {
        let newApplication = Application(company: company, title: title, status: status, date: date)
        applications.append(newApplication)
    }
    
    func deleteApplication(app: Application) {
            if let index = applications.firstIndex(where: { $0.id == app.id }) {
                applications.remove(at: index)
            }
    }
}

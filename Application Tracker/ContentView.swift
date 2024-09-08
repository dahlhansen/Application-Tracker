//
//  ContentView.swift
//  Application Tracker
//
//  Created by Frederik Dahl Hansen on 07/09/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                Text("Hello, world!")
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Application Tracker")
                        .font(.headline)
                        .bold()
                        .frame(alignment: .center)
                    }
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    NavigationLink(destination: AddApplicationScreen()){
                        
                    Image(systemName: "plus")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }

struct AddApplicationScreen: View {
    @EnvironmentObject var applicationManager: ApplicationManager
    @State private var company: String = ""
    @State private var title: String = ""
    @State private var status: Status = .Applied
    @State private var date: Date = Date()
    
    var body: some View {
        
        Form {
            Section(header: Text("Application Details")) {
                TextField("Company", text: $company)
                TextField("Title", text: $title)
                Picker("Status", selection: $status) {
                    Text("Applied").tag(Status.Applied)
                    Text("Interview").tag(Status.Interview)
                    Text("Offer").tag(Status.Offer)
                }
                DatePicker("Date", selection: $date, displayedComponents: [.date])
            }
            Button("Add Application") {
                applicationManager.addApplication(company: company, title: title, status: status, date: date)
            }
            .disabled(company.isEmpty || title.isEmpty)
        }
        .navigationTitle("Add Application")
        .navigationBarBackButtonHidden(true)
    }
    
    
}


#Preview {
    ContentView()
}

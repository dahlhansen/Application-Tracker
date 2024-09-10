//
//  ContentView.swift
//  Application Tracker
//
//  Created by Frederik Dahl Hansen on 07/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var applicationManager = ApplicationManager()
    
    var body: some View {
        NavigationView{
            VStack (alignment: .leading) {
                
                ForEach($applicationManager.applications) { $app in
                    VStack {
                        Text(app.company)
                            .font(.headline)
                        Text(app.title)
                            .font(.subheadline)
                        Picker("Status", selection: $app.status) {
                            Text("Applied").tag(Status.applied)
                            Text("Interview").tag(Status.interview)
                            Text("Awaiting Response").tag(Status.awaitingResponse)
                            Text("Offer").tag(Status.offer)
                            Text("Accepted").tag(Status.accepted)
                        }
                            
                        Text("Date: \(DateFormatter.localizedString(from: app.date, dateStyle: .long, timeStyle: .none))")
                        
                    }
                }
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
                    
                    NavigationLink(destination: AddApplicationScreen()
                        .environmentObject(applicationManager)
                    ){
                        
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
    @State private var status: Status = .applied
    @State private var date: Date = Date()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        Form {
            Section(header: Text("Application Details")) {
                TextField("Company", text: $company)
                TextField("Title", text: $title)
                Picker("Status", selection: $status) {
                    Text("Applied").tag(Status.applied)
                    Text("Interview").tag(Status.interview)
                    Text("Awaiting Response").tag(Status.awaitingResponse)
                    Text("Offer").tag(Status.offer)
                }
                DatePicker("Date", selection: $date, displayedComponents: [.date])
            }
            Button("Add Application") {
                applicationManager.addApplication(company: company, title: title, status: status, date: date)
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(company.isEmpty || title.isEmpty)
            
        }
        .navigationTitle("Add Application")
        .navigationBarBackButtonHidden(true)
    }
    
    
}


#Preview {
    ContentView()
        .environmentObject(ApplicationManager())
}

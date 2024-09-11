import SwiftUI

struct ContentView: View {
    @StateObject var applicationManager = ApplicationManager()
    
    let itemWidthPercentage: CGFloat = 0.9
    let fixedItemWidth: CGFloat = UIScreen.main.bounds.width * 0.9
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    if applicationManager.applications.isEmpty {
                        Text("Add an Application to get started")
                            .padding()
                    }
                    
                    ForEach($applicationManager.applications) { $app in
                        VStack (alignment: .leading) {
                            Text(app.company)
                                .font(.headline)
                            Text(app.title)
                                .font(.subheadline)
                            Picker("Status", selection: $app.status) {
                                Text("Applied").tag(Status.applied)
                                Text("Interview").tag(Status.interview)
                                Text("Awaiting Response").tag(Status.awaitingResponse)
                                Text("Offer").tag(Status.offer)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                                
                            Text("Date: \(DateFormatter.localizedString(from: app.date, dateStyle: .long, timeStyle: .none))")
                                .font(.footnote)
                        }
                        .padding()
                        .background(Color.mint)
                        .cornerRadius(16)
                        .frame(width: fixedItemWidth)
                        .padding(.horizontal, 8)
                        .shadow(radius: 2)
                    }
                    .padding(.top)
                }
            }
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
                    ) {
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

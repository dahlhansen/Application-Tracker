import SwiftUI

struct ContentView: View {
    @StateObject var applicationManager = ApplicationManager()
    
    let itemWidthPercentage: CGFloat = 0.9
    let fixedItemWidth: CGFloat = UIScreen.main.bounds.width * 0.9
    
    let darkBlue = Color(red: 0.0, green: 0.0, blue: 0.55)
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemMint], for: .selected)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    if applicationManager.applications.isEmpty {
                        Text("Add an Application to get started")
                            .padding()
                    }
                    
                    ForEach($applicationManager.applications) { $app in
                        ZStack(alignment: .topTrailing) {
                            VStack(alignment: .leading) {
                                Text(app.company)
                                    .font(.headline)
                                    .foregroundStyle(Color.white)
                                    .bold()
                                    .underline()
                                Text(app.title)
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundStyle(Color.white)
                                Picker("Status", selection: $app.status) {
                                    Text("Applied").tag(Status.applied)
                                    Text("Interview").tag(Status.interview)
                                    Text("Awaiting Response").tag(Status.awaitingResponse)
                                    Text("Offer").tag(Status.offer)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .accentColor(darkBlue)
                                    
                                Text("\(DateFormatter.localizedString(from: app.date, dateStyle: .long, timeStyle: .none))")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundStyle(Color.white)
                            }
                            .padding()
                            .background(Color.mint)
                            .cornerRadius(16)
                            .frame(width: fixedItemWidth)
                            .padding(.horizontal, 8)
                            .shadow(radius: 2)
                            
                            Button(action: {
                                applicationManager.deleteApplication(app: app)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .padding()
                            }
                        }
                        .padding(.top)
                    }
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
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
        .environmentObject(ApplicationManager())
}

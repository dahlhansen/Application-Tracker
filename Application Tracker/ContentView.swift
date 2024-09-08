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
    var body: some View {
        VStack {
            Text("Add New Item")
                .font(.largeTitle)
                .padding()
        }
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Add an Application")
                    .font(.headline)
                    .bold()
                    .frame(alignment: .center)
                }
            }
    }
}


#Preview {
    ContentView()
}

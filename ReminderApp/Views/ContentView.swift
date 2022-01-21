//
//  ContentView.swift
//  ReminderApp
//
//  Created by Ben Freeman on 2022-01-20.
//

import SwiftUI

struct ContentView: View {
    
  @ObservedObject  var store: TaskStore
    
    @State private var showingAddTask = false
    
    var body: some View {
        List(store.tasks) { task in
            TaskCell(task: task)
        }
        .navigationTitle("Reminder")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    showingAddTask = true
                }
            }
        }
        .sheet(isPresented: $showingAddTask) {
            AddTask(showing: $showingAddTask)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        ContentView(store: testStore)
        }
    }
}

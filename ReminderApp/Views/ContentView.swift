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
    
    @State var showingCompletedTasks = true
    
    @State var listShouldUpdate = false
    
    var body: some View {
        
        let _ = print("listShouldUpdate has been toggled. Current value is: \(listShouldUpdate)")
        
        List {
            ForEach(store.tasks) { task in
                
                if showingCompletedTasks {
                
                    TaskCell(task: task, triggerListUpdate: .constant(true))
                    
                } else {
                    
                    
                    if task.completed == false {
                        TaskCell(task: task, triggerListUpdate: $listShouldUpdate)
                    }
                    
                }
                
            }
            .onDelete(perform: store.deleteItems)
            .onMove(perform: store.moveItem)
        }

        .navigationTitle("Reminder")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    showingAddTask = true
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .bottomBar) {
                Button(showingCompletedTasks ? "Hide  completed sasks" : "Show completed Tasks") {
                    print("Value of showigcompletedTasks was: \(showingCompletedTasks)")
                    showingCompletedTasks.toggle()
                    print("Value of showingCompletedTasks in now \(showingCompletedTasks)")
                }
            }
        }
        .sheet(isPresented: $showingAddTask) {
            AddTask(store: store, showing: $showingAddTask)
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

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
    
    @State private var slectedPriorityForVisibleTasks: VisibleTaskPriority = .all
    
    @State var listShouldUpdate = false
    
    var body: some View {
        
        let _ = print("listShouldUpdate has been toggled. Current value is: \(listShouldUpdate)")
        
        VStack {
            
            Text("Filter by...")
                .font(Font.caption.smallCaps())
                .foregroundColor(.secondary)
            
            Picker("Priority", selection: $slectedPriorityForVisibleTasks) {
                Text(VisibleTaskPriority.all.rawValue)
                    .tag(VisibleTaskPriority.all)
                Text(VisibleTaskPriority.low.rawValue)
                    .tag(VisibleTaskPriority.low)
                Text(VisibleTaskPriority.medium.rawValue)
                    .tag(VisibleTaskPriority.medium)
                Text(VisibleTaskPriority.high.rawValue)
                    .tag(VisibleTaskPriority.high)

                
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
        List {
            ForEach(store.tasks) { task in
                
                if showingCompletedTasks {

                    if slectedPriorityForVisibleTasks == .all {
                        TaskCell(task: task, triggerListUpdate: .constant(true))
                    } else {
                        
                        if task.priority.rawValue == slectedPriorityForVisibleTasks.rawValue {
                            TaskCell(task: task, triggerListUpdate: .constant(true))
                        }
                        
                    }
                    
                } else {
                    
                    
                    if task.completed == false {
                        
                        if slectedPriorityForVisibleTasks == .all{
                            
                            TaskCell(task: task, triggerListUpdate: $listShouldUpdate)

                        }
                        
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        ContentView(store: testStore)
        }
    }
}

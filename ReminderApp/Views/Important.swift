//
//  Important.swift
//  ReminderApp
//
//  Created by Ben Freeman on 2022-01-25.
//

import SwiftUI

struct Important: View {
    
    @ObservedObject  var store: TaskStore
      
      @State private var showingAddTask = false
      
      @State var showingCompletedTasks = true
      
      @State private var slectedPriorityForVisibleTasks: VisibleTaskPriority = .high
      
      @State var listShouldUpdate = false
      
    var body: some View {
        
        let _ = print("listShouldUpdate has been toggled. Current value is: \(listShouldUpdate)")
        
        VStack {

            
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

        .navigationTitle("Important!")
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

    //struct Important_Previews: PreviewProvider {
    //    static var previews: some View {
    //        Important()
    //    }
    //}

//
//  TaskStore.swift
//  ReminderApp
//
//  Created by Ben Freeman on 2022-01-20.
//

import Foundation

class TaskStore: ObservableObject {
    @Published var tasks: [Task]
    
    init(tasks: [Task] = []) {
        self.tasks = tasks
    }
}

let taskStore = TaskStore(tasks: testData)

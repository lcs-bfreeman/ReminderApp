//
//  TaskStore.swift
//  ReminderApp
//
//  Created by Ben Freeman on 2022-01-20.
//

import Foundation

class TaskStore: ObservableObject {
    // MARK: Stored properties
    @Published var tasks: [Task]
    // MARK: Initializers
    init(tasks: [Task] = []) {
        self.tasks = tasks
    }
    
    // MARK: Functions
    func deleteItems(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

let testStore = TaskStore(tasks: testData)

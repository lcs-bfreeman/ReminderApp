//
//  TaskStore.swift
//  ReminderApp
//
//  Created by Ben Freeman on 2022-01-20.
//

import Foundation
import SwiftUI

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
    
    func moveItem (from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
    }
}

var testStore = TaskStore(tasks: testData)

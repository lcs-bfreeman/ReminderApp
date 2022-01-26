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
        
        let filename = getDocumentsDirectory().appendingPathComponent(savedTasksLabel)
        print(filename)
        
        do {
            
            let data = try Data(contentsOf: filename)
            
            print(String(data: data, encoding: .utf8)!)
            
            self.tasks = try JSONDecoder().decode([Task].self, from: data)
            
        } catch {
            print(error.localizedDescription)
            print("Double not load data fro, file. Initializeing with tasks provided to initializer")
            
            self.tasks = tasks
            
        }
    }
    
    // MARK: Functions
    func deleteItems(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        
    }
    
    func moveItem (from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func persistTasks() {
        let filename = getDocumentsDirectory().appendingPathComponent(savedTasksLabel)
        
        do {
            let encoder = JSONEncoder()
            
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(self.tasks)
            
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            print("Saved data documents directory succesfully")
            print("====")
            print(String(data: data, encoding: .utf8)!)
            
        } catch {
                print(error.localizedDescription)
                print("Unable to write list of tasks to directory in app bundle on device.")
        }
    }
    
}

var testStore = TaskStore(tasks: testData)

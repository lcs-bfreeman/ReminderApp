//
//  Task.swift
//  ReminderApp
//
//  Created by Ben Freeman on 2022-01-20.
//

import Foundation


enum TaskCodingKeys: CodingKey {
    case description
    case priority
    case completed
}

class Task: Identifiable, ObservableObject, Codable {
    
    //MARK: Storeed properties
    var id = UUID()
    var description: String
    var priority: TaskPriority
    @Published var completed: Bool
    
    // MARK: Initializers
    internal init(id: UUID = UUID(), description: String, priority: TaskPriority, completed: Bool) {
        self.id = id
        self.description = description
        self.priority = priority
        self.completed = completed
    }
    
    //MARK: Functions
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: TaskCodingKeys.self)
        
        try container.encode(description, forKey: .description)
        try container.encode(priority.rawValue, forKey: .priority)
        try container.encode(completed, forKey: .completed)

    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TaskCodingKeys.self)
        
        self.description = try container.decode(String.self, forKey: .description)
        self.priority = try container.decode(TaskPriority.self, forKey: .priority)
        self.completed = try container.decode(Bool.self, forKey: .completed)

    }
}

let testData = [
    Task(description: "Grow long hair", priority: .high, completed: true),
    Task(description: "Get modeling contract", priority: .medium, completed: false),
    Task(description: "Retire from teaching", priority: .low, completed: false),
]

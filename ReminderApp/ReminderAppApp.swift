//
//  ReminderAppApp.swift
//  ReminderApp
//
//  Created by Ben Freeman on 2022-01-20.
//

import SwiftUI

@main
struct ReminderAppApp: App {
    
 @StateObject private var store = TaskStore(tasks: testData)
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}

//
//  ReminderAppApp.swift
//  ReminderApp
//
//  Created by Ben Freeman on 2022-01-20.
//

import SwiftUI

@main
struct ReminderAppApp: App {
    
    @Environment(\.scenePhase) var scenephase
    
 @StateObject private var store = TaskStore(tasks: testData)
    
    var body: some Scene {
        WindowGroup {
            TabView {
            
            NavigationView {
            ContentView(store: store)
            }
            .tabItem{
                Image(systemName:  "square.and.pencil")
                Text("Reminders")
            }
            
            NavigationView {
                Important(store: store)
            }
            .tabItem{
                Image(systemName: "exclamationmark.triangle" )
                Text("Important")
            }
            }
            }
        .onChange(of: scenephase) { newPhase in
            
            if newPhase == .inactive {
                print("Interactive")
            } else if newPhase == .active {
                
                print("Active")
                
            } else if newPhase == .background {
                
                print("Background")
                
                store.persistTasks()
                
            }

    }
}
}

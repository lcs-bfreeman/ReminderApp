//
//  ContentView.swift
//  ReminderApp
//
//  Created by Ben Freeman on 2022-01-20.
//

import SwiftUI

struct ContentView: View {
    
  @ObservedObject  var store: TaskStore
    
    var body: some View {
        List(store.tasks) { task in
            HStack {
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                Text(task.description)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: testStore)
    }
}

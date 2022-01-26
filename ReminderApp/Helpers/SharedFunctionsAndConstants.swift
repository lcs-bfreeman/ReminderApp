//
//  SharedFunctionsAndConstants.swift
//  ReminderApp
//
//  Created by Ben Freeman on 2022-01-25.
//

import Foundation


func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}


let savedTasksLabel = "savedTasks"

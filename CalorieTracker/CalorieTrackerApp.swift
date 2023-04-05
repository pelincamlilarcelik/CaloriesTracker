//
//  CalorieTrackerApp.swift
//  CalorieTracker
//
//  Created by Onur Celik on 4.04.2023.
//

import SwiftUI

@main
struct CalorieTrackerApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

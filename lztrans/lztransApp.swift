//
//  lztransApp.swift
//  lztrans
//
//  Created by jsw_cool on 2023/7/4.
//

import SwiftUI

@main
struct lztransApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { phase in
            switch phase{
            case .active:
                print("Application is active")
            case .background:
                print("Application is background")
            case .inactive:
                print("Application is inactive")
            @unknown default:
                print("unexpected value.")
            }
        }
    }
   
}

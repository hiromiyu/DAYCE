//
//  Secret_DairyApp.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/07/30.
//

import SwiftUI

@main
struct Secret_DairyApp: App {
    let persistenceController = PersistenceController.shared
   
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

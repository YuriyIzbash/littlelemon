//
//  littlelemonApp.swift
//  littlelemon
//
//  Created by yuriy on 4. 9. 25.
//

import SwiftUI

@main
struct littlelemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


// ===============================================
//  iOSApp5App.swift
//  iOSApp5
// ===============================================
//  Created by Fozia Akhtar
// ===============================================
//  Purpose:
//  Main entry point of the application.
//  Creates shared AppSettings object.
//  Applies theme and settings across the app.
// ===============================================
//  Learning Outcomes:
//  ✓ EnvironmentObject
//  ✓ Theme Switching
//  ✓ Dynamic Appearance
// ===============================================

import SwiftUI


@main
struct iOSApp5App: App {


    // Shared settings object available throughout the app
    @StateObject private var settings = AppSettings()



    // Detect application lifecycle changes
    @Environment(\.scenePhase) private var scenePhase



    var body: some Scene {


        WindowGroup {


            MainView()

                // Makes settings available to all views
                .environmentObject(settings)


                // Applies Light/Dark/System mode
                .preferredColorScheme(
                    settings.colorScheme
                )



        }


        // Detect when app becomes active
        .onChange(
            of: scenePhase
        ) { newPhase in


            if newPhase == .active {


                settings.loadSettings()


            }

        }
    }
}

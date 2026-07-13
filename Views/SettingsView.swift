
// ===============================================
//  SettingsView.swift
//  iOSApp5
// ===============================================
//  Created by Fozia Akhtar
// ===============================================
//  Purpose:
//  Displays current application settings.
//  Shows values stored from Settings.bundle.
// ===============================================
//  Learning Outcomes:
//  ✓ EnvironmentObject
//  ✓ UserDefaults
//  ✓ Dynamic Appearance
// ===============================================

import SwiftUI


struct SettingsView: View {


    // Receives shared settings from the app
    @EnvironmentObject var settings: AppSettings



    var body: some View {


        VStack(spacing: 20) {


            Text("App Settings")
                .font(.largeTitle)
                .bold()



            Divider()



            Text("Theme Mode: \(settings.themeMode)")
            

            Text("Background Colour: \(settings.backgroundColour)")
            

            Text(
                "Auto Play: \(settings.autoPlay ? "ON" : "OFF")"
            )


            Text(
                String(
                    format: "Default Volume: %.1f",
                    settings.defaultVolume
                )
            )



        }

        .padding()

        // Applies selected background colour
        .background(
            settings.getBackgroundColour()
                .ignoresSafeArea()
        )



        .navigationTitle("Settings")
    }
}



#Preview {

    NavigationStack {

        SettingsView()

            .environmentObject(
                AppSettings()
            )
    }
}

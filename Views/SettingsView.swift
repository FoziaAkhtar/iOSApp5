
// ===============================================
//  SettingsView.swift
//  iOSApp5
// ===============================================
//  Created by Fozia Akhtar
// ===============================================
//  Purpose:
//  Displays current application settings.
//  Shows values loaded from Settings.bundle.
// ===============================================
//  Learning Outcomes:
//  ✓ EnvironmentObject
//  ✓ UserDefaults
//  ✓ Dynamic Appearance
// ===============================================

import SwiftUI



struct SettingsView: View {



    // Receives shared settings from the application
    @EnvironmentObject var settings: AppSettings






    var body: some View {


        VStack(spacing: 25) {



            // Screen title
            Text("App Settings")

                .font(.largeTitle)

                .bold()






            Divider()






            // Displays current theme selection
            Text(

                "Theme Mode: \(settings.themeMode)"

            )







            // Displays selected background colour
            Text(

                "Background Colour: \(settings.backgroundColour)"

            )







            // Displays automatic video playback status
            Text(

                "Auto Play: \(settings.autoPlay ? "ON" : "OFF")"

            )







            // Displays default audio volume
            Text(

                String(

                    format: "Default Volume: %.1f",

                    settings.defaultVolume

                )

            )







        }

        .padding()



        // Applies selected background colour
        // with opacity so text remains visible
        .background(

            settings.getBackgroundColour()

                .opacity(0.3)

                .ignoresSafeArea()

        )



        .navigationTitle("Settings")

    }
}







#Preview {


    NavigationStack {


        SettingsView()


    }

    .environmentObject(

        AppSettings()

    )

}

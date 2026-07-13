
// ================================
//  MainView.swift
//  iOSApp5
// ================================
//  Created by Fozia Akhtar
// ================================
//  Purpose:
//  Main screen of the application.
//  Contains the three tabs:
// ================================
//  • Videos
//  • Audio
//  • Settings
// ================================
//  Learning Outcomes:
//  ✓ TabView
//  ✓ NavigationStack
//  ✓ EnvironmentObject
//  ✓ Dynamic Appearance
// =================================

import SwiftUI



struct MainView: View {



    // Access shared application settings
    @EnvironmentObject var settings: AppSettings






    var body: some View {


        TabView {



            // MARK: - Videos Tab


            NavigationStack {


                // Displays all videos from app bundle
                VideoListView()


            }

            .tabItem {


                Label(

                    "Videos",

                    systemImage: "film"

                )

            }







            // MARK: - Audio Tab


            NavigationStack {


                // Displays all audio files from app bundle
                AudioListView()


            }

            .tabItem {


                Label(

                    "Audio",

                    systemImage: "music.note"

                )

            }







            // MARK: - Settings Tab


            NavigationStack {


                // Displays application settings
                SettingsView()


            }

            .tabItem {


                Label(

                    "Settings",

                    systemImage: "gearshape"

                )

            }



        }



        // Applies selected background colour
        // from Settings.bundle
        .background(

            settings.getBackgroundColour()

                .ignoresSafeArea()

        )

    }
}






#Preview {


    MainView()

        .environmentObject(

            AppSettings()

        )

}

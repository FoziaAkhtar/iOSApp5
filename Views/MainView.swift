
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
//  ✓ NavigationLink
// =================================

import SwiftUI



struct MainView: View {



    // Access shared application settings
    @EnvironmentObject var settings: AppSettings





    var body: some View {



        TabView {






            // MARK: - Videos Tab



            NavigationStack {


                // Displays all videos from bundle
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


                // Displays all audio files from bundle
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





        // Apply selected background colour
        .background(

            settings.getBackgroundColour()

        )

    }

}







#Preview {


    MainView()

        .environmentObject(

            AppSettings()

        )

}

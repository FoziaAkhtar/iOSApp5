
//  ================================
//  MainView.swift
//  iOSApp5
//  ================================
//  Created by Fozia Akhtar
//  ================================
//  Purpose:
//  Main screen of the application.
//  Contains the three tabs:
//  ================================
//  • Videos
//  • Audio
//  • Settings
//  ================================
//  Learning Outcomes:
//  ✓ TabView
//  ✓ NavigationStack
// =================================

import SwiftUI

struct MainView: View {

    var body: some View {

        TabView {

            NavigationStack {
                VideoListView()

            }
            .tabItem {

                Label("Videos", systemImage: "film")
            }

            NavigationStack {

                Text("Audio Coming Soon")
                    .font(.title)

            }
            .tabItem {

                Label("Audio", systemImage: "music.note")
            }

            NavigationStack {

                Text("Settings Coming Soon")
                    .font(.title)

            }
            .tabItem {

                Label("Settings", systemImage: "gearshape")
            }
        }
    }
}

#Preview {

    MainView()
}


// ===========================================================
//  AppSettings.swift
//  iOSApp5
// ===========================================================
//  Created by Fozia Akhtar
// ===========================================================
//  Purpose:
//  Manages application settings from Settings.bundle.
//  Reads user preferences using UserDefaults.
//  Updates the app when settings change.
// ===========================================================
//  Learning Outcomes:
//  ✓ UserDefaults
//  ✓ NotificationCenter
//  ✓ ObservableObject
//  ✓ Published Properties
//  ✓ Theme Management
// ===========================================================

import SwiftUI
import Foundation
import Combine


// ObservableObject allows SwiftUI views to receive setting updates
class AppSettings: ObservableObject {


    // MARK: - Published Settings


    // Current theme selection
    @Published var themeMode: String = "system"


    // Current background colour selection
    @Published var backgroundColour: String = "white"


    // Controls automatic video playback
    @Published var autoPlay: Bool = true


    // Default audio volume level
    @Published var defaultVolume: Float = 0.7



    // MARK: - Initialization


    // Load settings when the object is created
    init() {

        loadSettings()


        // Listen for changes made in Settings.bundle
        NotificationCenter.default.addObserver(

            self,

            selector: #selector(settingsChanged),

            name: UserDefaults.didChangeNotification,

            object: nil
        )
    }



    // MARK: - Settings Updates


    // Called when UserDefaults values change
    @objc private func settingsChanged() {


        // Update UI on the main thread
        DispatchQueue.main.async {


            self.loadSettings()

        }
    }



    // MARK: - Load UserDefaults


    /// Loads all preferences from Settings.bundle.
    /// Uses UserDefaults to store and retrieve values.
    func loadSettings() {


        let defaults = UserDefaults.standard



        // Read theme setting
        themeMode = defaults.string(
            forKey: "theme_mode"
        ) ?? "system"



        // Read background colour setting
        backgroundColour = defaults.string(
            forKey: "background_colour"
        ) ?? "white"



        // Read auto play setting
        autoPlay = defaults.bool(
            forKey: "auto_play"
        )



        // Read volume setting
        defaultVolume = defaults.float(
            forKey: "default_volume"
        )



        // Set default volume if no value exists
        if defaultVolume == 0 {

            defaultVolume = 0.7

        }

    }



    // MARK: - Theme Support


    // Converts theme selection into SwiftUI ColorScheme
    var colorScheme: ColorScheme? {


        switch themeMode {


        case "light":

            return .light



        case "dark":

            return .dark



        default:

            return nil

        }
    }



    // MARK: - Background Colour


    // Returns selected background colour
    func getBackgroundColour() -> Color {


        switch backgroundColour {


        case "gray":

            return Color.gray



        case "yellow":

            return Color.yellow



        case "blue":

            return Color.blue



        default:

            return Color.white

        }
    }
}


// ===============================================
//  Video.swift
//  iOSApp5
//
//  Created by Fozia Akhtar
// ===============================================
//  Purpose:
//  This file stores information about each video.
// ===============================================
//  Learning Outcomes:
//  • Model
//  • Identifiable
// ================================================

import UIKit

// Represents one video in the app.
struct Video: Identifiable {

    // Unique ID for SwiftUI Lists
    let id = UUID()

    // Display name shown to the user
    let name: String

    // File name inside the app bundle
    let fileName: String

    // Thumbnail image generated from the video
    let thumbnail: UIImage?

    // Video duration
    let duration: String
}


// ========================================
//  Audio.swift
//  iOSApp5
// =========================================
//  Created by Fozia Akhtar
// =========================================
//  Purpose:
//  Stores information for each audio file.
// =========================================
//  Learning Outcomes:
//  • Model
//  • Identifiable
// ==========================================

import Foundation

// Represents one audio file.
struct Audio: Identifiable {

    // Unique identifier
    let id = UUID()

    // Audio title
    let name: String

    // File inside the bundle
    let fileName: String

    // Audio duration
    let duration: String
}
